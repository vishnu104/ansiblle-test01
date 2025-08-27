#!/usr/bin/env python3

import boto3
import json
import sys

def get_inventory():
    ec2 = boto3.client('ec2', region_name='ap-southeast-2')  # Set your region

    response = ec2.describe_instances(
        Filters=[{'Name': 'instance-state-name', 'Values': ['running']}]
    )

    inventory = {}
    hostvars = {}

    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            ip = instance.get('PublicIpAddress') or instance.get('PrivateIpAddress')
            if not ip:
                continue

            tags = {tag['Key']: tag['Value'] for tag in instance.get('Tags', [])}
            group = tags.get('Role', 'ungrouped')  # Group by 'Role' tag

            if group not in inventory:
                inventory[group] = {'hosts': [], 'vars': {}}

            inventory[group]['hosts'].append(ip)

            hostvars[ip] = {
                'ansible_host': ip,
                'instance_id': instance['InstanceId'],
                'availability_zone': instance['Placement']['AvailabilityZone'],
                'instance_type': instance['InstanceType'],
                'tags': tags
            }

    return {
        **inventory,
        '_meta': {
            'hostvars': hostvars
        }
    }

def main():
    if len(sys.argv) == 2 and sys.argv[1] == '--list':
        print(json.dumps(get_inventory(), indent=2))
    elif len(sys.argv) == 3 and sys.argv[1] == '--host':
        host = sys.argv[2]
        inventory = get_inventory()
        print(json.dumps(inventory['_meta']['hostvars'].get(host, {}), indent=2))
    else:
        print(json.dumps({}))

if __name__ == '__main__':
    main()

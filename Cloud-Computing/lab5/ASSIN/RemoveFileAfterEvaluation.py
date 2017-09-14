'''
Author: SaiKumar Immadi
Creating an Autoscaling Group and specifying scale up and scale down policies and defining cloudwatch alarms using boto
5th Semester @ IIIT Guwahati
'''

# You can use this code for free. Just don't plagiarise it for your lab assignments

# don't run this file just after running autoscale remove file
# wait for 3-4 mins or you will find yourself in an infinite loop

import boto.ec2
import boto.ec2.autoscale
from boto.ec2.autoscale import LaunchConfiguration
from boto.ec2.autoscale import AutoScalingGroup
from boto.ec2.autoscale import ScalingPolicy
import boto.ec2.cloudwatch
from boto.ec2.cloudwatch import MetricAlarm
from time import sleep
conn = boto.ec2.autoscale.connect_to_region('us-east-1')
data_script = """#!/bin/bash
sudo apt-get update
sudo apt-get install python-pip -y
pip install boto
echo "import boto" > download_html.py
# **need to create a IAM user and insert his credentials below. give him only permissions for read only s3 access**
echo "s3=boto.connect_s3(aws_access_key_id='AKIAJZPUBKMH6FY5VZZQ',aws_secret_access_key='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')" >> download_html.py
echo "bucket=s3.get_bucket('happytravellerlab3bucket')" >> download_html.py
echo "key1=bucket.get_key('files/first.html')" >> download_html.py
echo "key2=bucket.get_key('files/second.html')" >> download_html.py
echo "key3=bucket.get_key('files/third.html')" >> download_html.py
echo "key1.get_contents_to_filename('first.html')" >> download_html.py
echo "key2.get_contents_to_filename('second.html')" >> download_html.py
echo "key3.get_contents_to_filename('third.html')" >> download_html.py
sudo python download_html.py
sudo apt-get install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
sudo mkdir /var/www/html/test-web
sudo cp first.html /var/www/html/test-web/first.html
sudo cp second.html /var/www/html/test-web/second.html
sudo cp third.html /var/www/html/test-web/third.html
sudo systemctl restart apache2"""

#reservation=conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'],user_data=data_script)
lc = LaunchConfiguration(name='my_launch_config',image_id='ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'],user_data=data_script)

conn.create_launch_configuration(lc)

ag = AutoScalingGroup(group_name='my_autoscale_group',availability_zones=['us-east-1a','us-east-1b'],launch_config=lc, min_size=1,max_size=2,connection=conn)

conn.create_auto_scaling_group(ag)

scale_up_policy = ScalingPolicy(name='scale_up',adjustment_type='ChangeInCapacity',as_name='my_autoscale_group', scaling_adjustment=1,cooldown=180)

scale_down_policy = ScalingPolicy(name='scale_down',adjustment_type='ChangeInCapacity',as_name='my_autoscale_group', scaling_adjustment=-1,cooldown=180)

conn.create_scaling_policy(scale_up_policy)
conn.create_scaling_policy(scale_down_policy)

scale_up_policy = conn.get_all_policies(as_group='my_autoscale_group',policy_names=['scale_up'])[0]
scale_down_policy = conn.get_all_policies(as_group='my_autoscale_group',policy_names=['scale_down'])[0]

cloudwatch = boto.ec2.cloudwatch.connect_to_region('us-east-1')
alarm_dimensions = {"AutoScalingGroupName": 'my_autoscale_group'}

scale_up_alarm = MetricAlarm(name='scale_up_on_cpu',namespace='AWS/EC2',metric='CPUUtilization',statistic='Average',comparison='>',threshold='70',period='60',evaluation_periods=2,alarm_actions=[scale_up_policy.policy_arn],dimensions=alarm_dimensions)

cloudwatch.create_alarm(scale_up_alarm)

scale_down_alarm = MetricAlarm(name='scale_down_on_cpu',namespace='AWS/EC2',metric='CPUUtilization',statistic='Average',comparison='<',threshold='40',period='60',evaluation_periods=2,alarm_actions=[scale_down_policy.policy_arn],dimensions=alarm_dimensions)

cloudwatch.create_alarm(scale_down_alarm)

ec2 = boto.ec2.connect_to_region('us-east-1')
group = conn.get_all_groups(names=['my_autoscale_group'])[0]
instance_ids = [i.instance_id for i in group.instances]
instances = ec2.get_only_instances(instance_ids)
for instance in instances:
	while instance.state != u'running':
		print "Initialising Instances. Please wait!"
		sleep(6)
		instance.update()

print ""
for instance in instances:
    print "Instance Id :",instance.id
    print "Instance State :",instance.state
    print "Public DNS :",instance.public_dns_name
    print ""

import boto.ec2
from time import sleep
conn = boto.ec2.connect_to_region("us-east-1")
# conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'])
# conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'])
# conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'])
num_instances=0
all_instances=[]
all_instance_ids=[]
reservations=conn.get_all_reservations()
for reservation in reservations:
	instances=reservation.instances
	for instance in instances:
		if instance.state == u'stopped':
			all_instance_ids.append(instance.id)
			all_instances.append(instance)
			num_instances+=1
			print num_instances,instance.id
		print ""
conn.start_instances(instance_ids=all_instance_ids)
print "1st checkpoint"
for instance in all_instances:
	while instance.state != u'running':
		print instance.state
		print "Initialising Instances. Please wait!"
		sleep(3)
		instance.update()
sleep(3)
print "2nd checkpoint"
statuses = conn.get_all_instance_status()
for status in statuses:
	print status
	print status.events
	print status.instance_status
	print status.system_status
	print status.system_status.details
	print ""
print "3rd checkpoint"
conn.stop_instances(instance_ids=all_instance_ids)
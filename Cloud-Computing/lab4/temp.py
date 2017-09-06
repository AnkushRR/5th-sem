import boto.ec2
from time import sleep
conn = boto.ec2.connect_to_region("us-east-1")
# conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'])
# conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'])
# conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'])
num_instances=0
all_instance_ids=[]
all_instances=[]
reservations=conn.get_all_reservations()
for reservation in reservations:
	instances=reservation.instances
	for instance in instances:
		all_instance_ids.append(instance.id)
		all_instances.append(instance)
		num_instances+=1
		print num_instances,instance.id
		print ""
for instance in all_instances:
	print instance.state
	while instance.state == u'pending':
		sleep(3)
		instance.update()
print "done"
# statuses = conn.get_all_instance_status()
# for status in statuses:
# 	print status.events
# 	print status.instance_status
# 	print status.system_status
# 	print status.system_status.details
# 	print ""
# conn.stop_instances(instance_ids=all_instance_ids)
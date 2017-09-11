import boto.ec2.autoscale
from time import sleep
conn = boto.ec2.autoscale.connect_to_region('us-east-1')
conn.get_all_groups()[0].shutdown_instances()
ec2 = boto.ec2.connect_to_region('us-east-1')
# name of autoscale group from which instances have to be terminated
group = conn.get_all_groups(names=['my_autoscale_group'])[0]
instance_ids = [i.instance_id for i in group.instances]
instances = ec2.get_only_instances(instance_ids)
for instance in instances:
	print instance.id
	while instance.state != u'terminated':
		print instance.state
		sleep(6)
		instance.update()
print "Terminated all instances associated with the Autoscale group"
sleep(15)
conn.get_all_groups()[0].delete()
print "Deleted Autoscale group"
conn.get_all_launch_configurations()[0].delete()
print "Deleted Launch config"

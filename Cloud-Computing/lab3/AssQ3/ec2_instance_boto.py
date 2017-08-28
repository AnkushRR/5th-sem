'''
Author: SaiKumar Immadi
Creating an EC2 instance using Boto also takes files from S3
5th Semester @ IIIT Guwahati
'''

# You can use this code for free. Just don't plagiarise it for your lab assignments

import boto.ec2
from time import sleep
conn = boto.ec2.connect_to_region("us-east-1")
# web = conn.create_security_group('apache', 'Our Apache Group')
# web.authorize('tcp', 80, 80, '0.0.0.0/0')
# web.authorize('tcp', 22, 22, '0.0.0.0/0')
data_script = """#!/bin/bash
sudo apt-get update
sudo apt-get install python-pip -y
pip install boto
echo "import boto" > download_html.py
echo "s3=boto.connect_s3(aws_access_key_id='AKIAJDQEQ3F2AJWT6YEQ',aws_secret_access_key='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')" >> download_html.py
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


reservation=conn.run_instances('ami-cd0f5cb6',key_name='ec2_instance1',instance_type='t2.micro',security_groups=['apache'],user_data=data_script)
instance = reservation.instances[0]
print "New Instance Created with Instance Id :",instance.id

while instance.state == u'pending':
    print "Instance state: %s" % instance.state
    sleep(6)
    instance.update()
print "Instance state: %s" % instance.state
print "Public dns: %s" % instance.public_dns_name
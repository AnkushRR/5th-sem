import os 
import boto
import boto.s3.connection
conn = boto.s3.connect_to_region('us-east-1',
    aws_access_key_id = 'AWS-Access-Key',
    aws_secret_access_key = 'AWS-Secrete-Key',
    # host = 's3-website-us-east-1.amazonaws.com',
    # is_secure=True,               # uncomment if you are not using ssl
    calling_format = boto.s3.connection.OrdinaryCallingFormat(),
    )

    bucket = conn.create_bucket('happytravellermedia')
    full_key_name = os.path.join(path, key_name)
    k = bucket.new_key('files/upload_textfile.txt')
    k.set_contents_from_filename('/home/kilgrave/MyLife/5th-sem/Cloud-Computing/lab3/upload_textfile.txt')
# import boto
# s3=boto.connect_s3()
# bucket=s3.get_bucket('aws:s3:::media.happytraveller.com')
# key=bucket.new_key('files/simple_textfile.txt')
# key.set_contents_from_filename('/home/kilgrave/MyLife/5th-sem/Cloud-Computing/lab3/upload_textfile.txt')
# key.set_acl('public-read')

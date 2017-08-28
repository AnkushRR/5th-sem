import boto
s3=boto.connect_s3()
Bucket_Name='mediahappytraveller'
bucket=s3.create_bucket(Bucket_Name)
print "Bucket :",Bucket_Name,"created successfully!"
key=bucket.new_key('files/simple_textfile.txt')
print "New key created!"
key.set_contents_from_filename('/home/kilgrave/MyLife/5th-sem/Cloud-Computing/lab3/upload_textfile.txt')
key.set_acl('public-read')
print "File copied to s3 and set to public-read mode"
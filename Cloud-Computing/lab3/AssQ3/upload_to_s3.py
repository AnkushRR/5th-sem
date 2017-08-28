import boto
s3=boto.connect_s3()
Bucket_Name='happytravellerlab3bucket'
bucket=s3.create_bucket(Bucket_Name)
print "Bucket :",Bucket_Name,"created successfully!"
key1=bucket.new_key('files/first.html')
key2=bucket.new_key('files/second.html')
key3=bucket.new_key('files/third.html')
key1.set_contents_from_filename('first.html')
key2.set_contents_from_filename('second.html')
key3.set_contents_from_filename('third.html')
key1.set_acl('public-read')
key2.set_acl('public-read')
key3.set_acl('public-read')
print "Files copied to s3 and set to public-read mode"
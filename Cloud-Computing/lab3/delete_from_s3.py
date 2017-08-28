import boto
s3=boto.connect_s3()
Bucket_Name='mediahappytraveller'
bucket=s3.get_bucket(Bucket_Name)
for version in bucket.list_versions():
	bucket.delete_key(version.name,version_id=version.version_id)
	print "Key :",version.name,"has been deleted"
bucket.delete()
print "Bucket :",Bucket_Name,"deleted successfully!"

no_of_clusters=3
d=[]
x_mean={}
y_mean={}
x_temp={}
y_temp={}
count={}
cluster = {}
x_value = {}
y_value = {}
with open("input.txt") as file:
	for line in file:
		line = line.strip().split('\t');
        	x_value[line[0]]=line[1]
        	y_value[line[0]]=line[2]
i=0;
for i in range(0,no_of_clusters):
	x_temp[i]=0
	y_temp[i]=0
	count[i]=0
    	d.append(0)
for key in x_value:
	cluster[key]=i
        i=(i+1)%no_of_clusters
i=0;
for key in x_value:
	x_temp[cluster[key]]=x_temp[cluster[key]]+float(x_value[key])
	y_temp[cluster[key]]=y_temp[cluster[key]]+float(y_value[key])
	count[cluster[key]]=count[cluster[key]]+1
for i in range(0,no_of_clusters):
	if(count[i]>0):
		x_mean[i]=x_temp[i]/count[i]
		y_mean[i]=y_temp[i]/count[i]
		x_temp[i]=0
		y_temp[i]=0
		count[i]=0
k=1;
counter=0
while (k==1):
	counter+=1
	k=0
	for key in x_value:
		for i in range(0,no_of_clusters):
	                d[i]=((x_mean[i]-float(x_value[key]))*(x_mean[i]-float(x_value[key])))+((y_mean[i]-float(y_value[key]))*(y_mean[i]-float(y_value[key])))
		d_m=min(d)
                pos=d.index(min(d))
                if(cluster[key]!=pos):
			k=1
		cluster[key]=pos
	for key in x_value:
		x_temp[cluster[key]]=x_temp[cluster[key]]+float(x_value[key])
		y_temp[cluster[key]]=y_temp[cluster[key]]+float(y_value[key])
		count[cluster[key]]=count[cluster[key]]+1
	for i in range(0,no_of_clusters):
        	if(count[i]>0):
			x_mean[i]=round(x_temp[i]/count[i],2)
			y_mean[i]=round(y_temp[i]/count[i],2)
			x_temp[i]=0
			y_temp[i]=0
			count[i]=0
for i in range(0,no_of_clusters):
	print "Cluster" , i ,":(",x_mean[i],",",y_mean[i],")"
# print "Cluster nodes"
# print cluster
print counter
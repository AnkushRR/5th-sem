#name, roll no, current semester in one list 
students_info=[("Hannah Baker","CS34568",5),("Mike Ross","CS34569",5),("Cersei Lannister","EC34570",5),("Alex Dunphy","EC24571",3),("Clay Jensen","CS24572",3),("Dev Shah","CS14573",1),("Ted Mosby","EC14574",1),("Monica Geller","CS44575",7),("Ross Geller","EC44576",7)]
courses_info=[("MA101","Mathematics 1"),("CS101","Computer Programming"),("EC101","Digital Design"),("CS110","Computer Programming Lab"),("EC102","Electrical Circuit Ananlysis"),("HS101","English 1"),("HS201","English 2"),("HS301","English 3"),("HS401","English 4"),("MA201","Mathematics 2"),("MA301","Mathematics 3"),("MA401","Mathematics 4"),("CS201","Algorithms 1"),("CS231","Operating Systems"),("CS301","Algorithms 2"),("CS401","Algorithms 3"),("CS320","Compilers"),("CS440","Image Processing"),("EC201","Analog Circuits 1"),("EC301","Analog Circuits 2"),("EC401","Analog Circuits 3"),("EC380","Control Systems"),("EC462","Advanced Semiconductor Devices")]
#min three courses for each sem and max four courses
student_course={"CS34568":("MA301","HS301","CS301"),"CS34569":("MA301","HS301","CS301","CS320"),"EC14574":("MA101","EC101","EC102")}
student_info_file=open("student_info.txt","w") 
#student_info_file.write("Hello World")
for student_id in student_course:
	for student_info in students_info:
		if student_id in student_info:
			student_info_file.write("Student Id : "+student_id+" | Student Name : "+student_info[0]+"\n")
			break
	for course_id in student_course[student_id]:
		for course in courses_info:
			if course_id in course:
				student_info_file.write(course_id+" : "+course[1]+"\n")
				break
	student_info_file.write("\n\n")
student_info_file.close()
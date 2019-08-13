person_status = read.csv("legislatura_2019/person_status_2019.csv")

head(person_status)
cylinders <- table((person_status$Status), person_status$Nome[0])
head(cylinders)
barplot(cylinders)
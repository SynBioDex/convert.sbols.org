grep -B 1 "Fatal Error: Premature end of file." validate.log
grep -cH "Fatal Error: Premature end of file." validate.log
wc -l validate.log


::set path so AppScanCMD is accessible from the command prompt
set path=%path%;C:\Program Files (x86)\HCL\AppScan Standard

::set timestamp for the filename based on curent date time
::example: 20232806_132723
set mytimestamp=%date:~10,4%%date:~7,2%%date:~4,2%_%time:~0,2%%time:~3,2%%time:~6,2%

::define a filename for the resulting .scan file (no extension) 
::example: jenkins_20232806_132723
set scan_filename=jenkins_%mytimestamp%

::Define the full path of the .scan file
::example: C:\scan\jenkins_20232806_132723.scan
set scan_filenamepath=%cd%\%scan_filename%.scan

::Run a scan base on an existing .scant scan template, save the result in 
::appscancmd /st demo.testfire.net.scant /dest %scan_filenamepath% /sl

::Test only
appscancmd /base_scan C:\ScanTemplates\demotestfire_manualexplore.scan /dest %scan_filenamepath% /test_only /scan_log
::Generate a report
appscancmd report /base_scan %scan_filenamepath% /report_file %cd%\%scan_filename%.html -report_type html


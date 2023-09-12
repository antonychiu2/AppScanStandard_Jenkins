# AppScan Standard and Jenkins Integration Demo

# Introduction
This sample integration leverages AppScan Standard's CLI capability (appscancmd.exe) as well as Jenkins' "Execute windows batch command" to automate DAST scanning in an automated environment. 

In this example, We will be leveraging an existing scan template (.scant) which contains all the necessary configurations such as authentication, test policy, as well as any other parameters to conduct a successful DAST scan on our target application. 

## Pre-requisite
This is tested on AppScan Standard 10.2.0. It is possible that previous versions of ASD will also work as the commands used here are standard commands. 

## Step 1 - Creating the pipeline

In Jenkins, let's create a pipeline. In the "Build Step" section, let's add a "Windows Batch Command" step:

![image](https://github.com/antonychiu2/AppScanStandard_Jenkins/assets/5158535/d0fb53cb-d16b-4378-af9f-04a40029e277)

## Step 2 - Adding the build step

In the "Command section", let's add the following:
```bat
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

::Run a scan base on an existing .scant scan template, save the result in the .scan file
::appscancmd /st demo.testfire.net.scant /dest %scan_filenamepath% /sl

::OR for a quick test - let's do test instead of the above command 
appscancmd /base_scan C:\ScanTemplates\demotestfire_manualexplore.scan /dest %scan_filenamepath% /test_only /scan_log

::Generate a report
appscancmd report /base_scan %scan_filenamepath% /report_file %cd%\%scan_filename%.html -report_type html
```

## Step 3 - Extract HTML report

Add a post-build action  "Public HTML Reports" 
![image](https://github.com/antonychiu2/AppScanStandard_Jenkins/assets/5158535/fd908f24-792b-40c4-8265-8c7a9afb849a)

## Step 4 - Run the build and view HTML Report

After all configurations are complete, do a test build by using "Build Now". 

After the scan is complete, the HTML scan report should be available on the left hand side of the Job Dashboard:
![image](https://github.com/antonychiu2/AppScanStandard_Jenkins/assets/5158535/88354295-8c22-4cac-8a06-efb1f3aa019b)


## Additional Notes

Please note that your Jenkins's installation has to be running as the user who has proper AppScan License configured. The reason is because the AppScan Standard license is tied to the user profile. If your Jenkins instance runs under a service account, then we have to make sure AppScan license is also configured under that service account. 

![image](https://github.com/antonychiu2/AppScanStandard_Jenkins/assets/5158535/575d50dc-d241-432a-8609-08ee7a7ff4be)

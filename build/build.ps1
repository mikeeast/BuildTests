Properties {
	$framework = '4.0'
	$build_dir = Split-Path $psake.build_script_file	
	$build_output_dir = "$build_dir\output\"
	$code_dir = "$build_dir\..\"
	$tools_dir = "$code_dir\packages"
	$nunit_dir = "$tools_dir\NUnit.2.5.10.11092\tools"
	$env:path = "$env:path;$nunit_dir"
	$nunitlauncher=%teamcity.dotnet.nunitlauncher%
}

FormatTaskName (("-"*25) + "[{0}]" + ("-"*25))

Task Default -Depends BuildSolution

Task BuildSolution -Depends Info, Clean, Build, Test

Task Info {
	Write-Host "Build dir: $build_dir" -ForegroundColor Green
	Write-Host "Build output dir: $build_output_dir" -ForegroundColor Green
	Write-Host "Code dir: $code_dir" -ForegroundColor Green
	Write-Host "Nunit: ${global:teamcity.dotnet.nunitlauncher} $$nunitlauncher" 
}

Task Build -Depends Clean {	
	Write-Host "Building Solution" -ForegroundColor Green
	Exec { msbuild "$code_dir\MvcApplication4.sln" /t:Build /p:Configuration=Release /v:quiet /p:OutDir=$build_output_dir } 
}

Task Test -Depends Build {
	Write-Host "Testing" -ForegroundColor Green
	Exec { nunit-console-x86 "$build_output_dir\MvcApplication4.Tests.dll" /framework:net-4.0  }
}

Task Clean {
	Write-Host "Creating BuildArtifacts directory" -ForegroundColor Green
	if (Test-Path $build_output_dir) 
	{	
		rd $build_output_dir -rec -force | out-null
	}
	
	mkdir $build_output_dir | out-null
	
	Write-Host "Cleaning Solution" -ForegroundColor Green
	Exec { msbuild "$code_dir\MvcApplication4.sln" /t:Clean /p:Configuration=Release /v:quiet } 
}
cp -r C:\Users\Ahmed-Galai\Desktop\Development\Sandbox\pshell\django/lib .
$value1="$(C:\Users\Ahmed-Galai\Desktop\Development\Sandbox\pshell\django/scripts/ui.ps1)"

if (!$value1 -eq ''){
	$layout=($value1.split(',')[0])
	$theme=($value1.split(',')[1])
	$name=($value1.split(',')[2])
	echo '----------------------'
	echo '---- configuration: ----'
	write-host 'theme: ' -NoNewLine
	echo $theme
	write-host 'layout: ' -nonewline
	echo $layout
	write-host 'project name: ' -nonewline
	echo $name
	echo '----------------------'
	#$name | ./scripts/django.ps1
	######################### modified django.ps1

	$line="----"

	#Write-Output "$line enter project name: $line"
	#$projectname = Read-Host ">>> "
	$projectname=$name

	Write-Output "$line creating and entering root directory $line"
	mkdir "$projectname"
	echo ''
	Set-Location "$projectname"
	Write-Output "$line creating and activating the virtual enviroment $line"
	python3 -m venv env
	./env/Scripts/activate

	Write-Output "$line installing required packages $line"
	#pip install --upgrade pip
	pip install django
	pip freeze > requirements.txt

	Write-Output "$line starting the django project $line"
	django-admin startproject main

	Write-Output "$line starting the default app $line"
	Set-Location main
	py manage.py startapp default
	echo ''
	Write-Output "$line importing template and static files $line"
	mkdir default/templates/default
	mkdir default/static/default

	#Images and Icons
	Copy-Item -r ../../lib/icons ./default/static/default/
	Copy-Item -r ../../lib/images ./default/static/default/

	#css
	Copy-Item -r ../../lib/css ./default/static/default/
	mv default/static/default/css/lib/theme/$theme.css default/static/default/css/lib/theme/theme.css
	cp default/static/default/css/lib/theme/theme.css default/static/default/css/lib/theme/$theme.css

	#js
	Copy-Item -r ../../lib/js ./default/static/default/

	#html
	Copy-Item -r ../../lib/html/* ./default/templates/default/
	mv default/templates/default/lib/layouts/$layout.html default/templates/default/lib/layouts/layout.html
	cp default/templates/default/lib/layouts/layout.html default/templates/default/lib/layouts/$layout.html

	#python
	Copy-Item ../../lib/python/* ./default/
	Remove-Item ./main/urls.py
	Remove-Item ./main/settings.py
	Move-Item ./default/initial_urls.py ./main/urls.py
	Move-Item ./default/settings.py ./main/
	#subl .

	#Write-Output "$line\n deactivating the virtual enviroment \n$line"
	#deactivate

	Write-Output "$line making initial migrations $line"
	py manage.py makemigrations
	py manage.py migrate

	Write-Output "$line running test server $line"
	#subl .
	#py manage.py runserver
	deactivate
	cd ..
	start powershell {activate; cd main; py manage.py runserver}
	start chrome 127.0.0.1:8000
	cd ..
	Write-Host $line
	Write-Host "execution done!"
	#Write-Host "press the ENTER key to exit"
	Write-Host $line
	#cmd .
	#$q = Read-Host ">>> "
	#exit
}
rm -r lib
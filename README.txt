## README##
####Autoren:  
Wichert, Franz; Matr. 6003113; E-Mail: franz.nachname@student.jade-hs.de   
Hartog, Laura; Matr. 6005625; E-Mail: laura.nachname@student.jade-hs.de

###Motivation:
Im Rahmen der Vorlesung *Daten und Algorithmen* des Studiengangs *Hörtechnik und Audiologie* wurde als Prüfungsleistung ein Programm geschrieben, das die Anforderung, HRTFs mit verschiedenen Quell-Signalen probezuhören, erfüllt. Die zu verwendende Soundkarte ist vom Benutzer zu wählen und die Position der Tonquelle während der Widergabe festzulegen.


###Programmanleitung zum Skript 'hrtf_gui'
Zum Starten des Programms muss das Skript *hrtf_gui* geöffnet und ausgeführt werden. Es öffnet sich eine Benutzeroberfläche. Der Benutzer hat nun die Möglichkeit verschiedene Buttons zu verwenden, um die HRTFs des Quellsignals probezuhören:

* **find device**: Durch einen linken Mausklick auf diesen Button, werden die möglichen Soundkarts gesucht. In dem Pop-Up Menü kann der Benutzer anschließend den gewünschten Output wählen.  
* **Choose Source** Das Quellsignal kann in diesem Pop-Up Menü ausgewählt werden.
* **start audio** Das Abspielen des Quellsignals wird gestartet. 
* **Azimuth**: Durch einen linken Mausklick in das Azimuth-Fenster kann der gewünschte Azimuth-Winkel in Echtzeit bestimmt werden. 
* **Elevation**: Durch einen linken Mausklick in das Elevation-Fenster kann ein gewünschter Elevation-Winkel zwischen -40° und 90° in Echtzeit bestimmt werden.   
* **Achtung**: Zur Verwendung des Programms wird das Matlab Programm **msound** benötigt.

Die verwendeten HRTFs beruhen auf die Aufnahmen von [Gardner und Martin](http://sound.media.mit.edu/resources/KEMAR.html "Zum Öffnen Links-Klick"). Die daraus erstellten Matlab-Tabellen enthalten zudem aus den Azimuth-Winkeln 0°-180° gefolgerte Werte für Azimuth 180°-360°.


###Funktionsweise des Programms
In dem Skript  '**hrtf_gui**' wird die Benutzeroberfläche zum Probehören der HRTFs erstellt, die Quelle geladen, verarbeitet und abgespielt. Dieses geschieht mithilfe der im Folgenden verwendeten Funktionen:  

* **device_finder**: Erkennt In- und Output Devices und bietet diese in einem Pop-Up Menü an.     
* **azdir_change**: Registriert die Änderung in Azimuth als Koordinaten und berechnet den Winkel und die Position des Lautsprechers.  
* **eldir_change**: Registriert die Änderung in Elevation als Koordinaten und berechnet den Winkel und die Position des Lautsprechers. Bei einem Winkel > 90° wird automatisch eine Elevation von 90° verwendet, bei einem Winkel < 40° eine Elevation von 40°.       
* **start_audio**: In Echtzeit werden die vom Benutzer gewählten Einstellungen abgerufen und die entsprechenden HRTFs mithilfe der Funktion **interpolate** interpoliert und abgespielt.       
 

###Getestete Plattformen:

* Windows 7 Home Premium; MATLAB R2013a Student Version (32-bit)  
* Mac OS X Version 10.7.5; MATLAB R2012a Student Version (64-bit)

###Lizenzen###
Copyright (c) <2014> F. Wichert, L.Hartog   
Institute for Hearing Technology and Audiology   
Jade University of Applied Sciences
 


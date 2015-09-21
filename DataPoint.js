//DataPoint.
//This is an function that holds the relevent data of a single data point (recording) and is what will be passes between.
//The data point takes two parameters json and file.
//json: The JSON of the meta data of the data point, formated as shown below
//	{hardware: 	{key1:val1, key2:val2...},
//	software: 	{key1:val1, key2:val2...},
//	location:	{key1:val1, key2:val2...},
//	marinData:	{key1:val1, key2:val2...}}
//
//file: The file of the data point (the recording)

module.exports = function(json, file) {

this.dataBase;			//connection to the PostgreSQL DB.
this.postgreSQL;		//The PostgreSQL data base connection that the data point will be uploaded to.
this.fileName = file.name;		//The file to be uploaded.
this.tempFilePath = file.path;

this.checkedHardwareId = false;
this.checkedSoftwareId = false;
this.checkedLocationId = false;

this.newHardwareId = false;
this.newSoftwareId = false;
this.newLocationId = false;

this.uploaded = false;

//Parsing JSON
this.json = json;
this.hardware = json.hardware;	//JSON object that holds the device dardware info.
this.software = json.software;	//JSON object that holds the device software info.
this.location = json.location;	//JSON object that holds the location info.
this.mainData = json.mainData;	//JSON object containing the main data of the data point object.
if (json.mainData.fileExtension) {
	this.fileExtension = json.mainData.fileExtension;
} else {
	fileExtension = this.fileName.substr(this.fileName.lastIndexOf('.')+1);
}


this.deviceId;
if (json.deviceId) {
	this.deviceId = json.deviceId;	//ID of the device that was given to the device when it registered.
}

//TODO check if DataPoint is valid or not at this point.
console.log("New DataPoint created.");

//TODO This will return true if the datapoint is ready to upload the file (recording)
this.readyForFileUpload = function(){
	//TODO
	return true;
}

//TODO check that the data point s ready to be uploaded to the data base.
this.readyForUpload = function(){
	//TODO check that the file is valid
	if (this.deviceId && this.checkedHardwareId && this.checkedSoftwareId && this.checkedLocationId){
		return true;
	} else {
		if (!this.deviceId)		{ console.log("Invalid device id", this.deviceId) }
		if (!this.checkedHardwareId) { console.log("Hardware ID has not been validated") }
		if (!this.checkedSoftwareId) { console.log("Software ID has not been validated") }
		if (!this.checkedLocationId) { console.log("Location ID has not been validated.") }
		return false;
	}
}

//Get File Name: This function return the name/key that will be used when storing a file in the AWS S3.
this.getFileName = function(){
	var fileName = null;
	if (this.deviceId && this.mainData.startTimeUtc && fileExtension){
		fileName = this.deviceId + "/" + this.mainData.startTimeUtc + "." + fileExtension;
	} else {
		console.log("Error, invalid DEVICE_ID and/or START_TIME_UTC and/or FILE_EXTENSION.");
	}
	return fileName;
}

this.isValid = function(){
	if (hardware && software && location && mainData && file){
		//TODO add more validation checks
		return true;
	} else {
		if (!this.hardware) { console.log("Hardware is invalid", this.hardware); }
		if (!this.software) { console.log("Software is invalid", this.software); }
		if (!this.location) { console.log("Location is invalid", this.location); }
		if (!this.mainData) { console.log("MainData is invalid", this.mainData); }
		if (!file) {console.log("File is invalid", file); }
		return false;
	}
}
};
@ignore
Feature:

Background:
	# function for creating a random numeric value of length x
	# Input: length of value
	# output: random number of length x (input)
	* def random_number =
	"""
	function(x) {
	rand_str = '';
	char_list = '12345';
	char_length = char_list.length;
	for ( var i = 0; i < x; i++) {
		rand_str += char_list.charAt(Math.floor(Math.random() * char_length));
	}
	return rand_str;
	}
	"""

	# function to generate random run number, takes scenarioName and length of random number required as input
	# Extracts jira number from scenarioName and appends to random number e.g for JIRA": "JIRA-722", this will return
	# 722-2001521009 (10 is length)
	* def random_run_num =
	"""
	function(scenarioName, length) {
	 var thenum = scenarioName.replace( /\D/g, '');
	 return ''+ thenum +'-'+random_number(length);
	}
	"""

	# function for creating a random alpha-only value of length x
	# Input: length of value
	# output: random string of length x (input)
	* def random_string =
	"""
	function(x) {
	rand_str = '';
	char_list = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
	char_length = char_list.length;
	for ( var i = 0; i < x; i++) {
		rand_str += char_list.charAt(Math.floor(Math.random() * char_length));
	}
	return rand_str;
	}
	"""

	# function for creating a random alphanumberic value of length x
	# Input: length of value
	# output: random string of length x (input)
	* def random_numStr =
	"""
	function(x) {
	rand_str = '';
	char_list = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	char_length = char_list.length;
	for ( var i = 0; i < x; i++) {
		rand_str += char_list.charAt(Math.floor(Math.random() * char_length));
	}
	return rand_str;
	}
	"""
    
    
	# function to generate random run string based on a Jira number.
 	# takes scenarioName and length of random number required as input
	# Extracts jira number from scenarioName, converts it to excel column letter and appends to random number
 	# e.g for JIRA: "JIRA-496", this will return
	# SB-UOSS (4 is length)
	* def random_run_str =
	"""
	function(scenarioName, length) {
		var s = '',t;
	 	var num = scenarioName.replace( /\D/g, '');
		while (num > 0) {
			t = (num - 1) % 26;
			s = String.fromCharCode(65 + t) + s;
			num = (num - t)/26 | 0;
		}
	 	return s +'-'+random_string(length);
	}
	"""

	# function for creating a random alphanumberic with special chars value of length x
	# Input: length of value
	# output: random string of length x (input)
	* def random_all =
	"""
	function(x) {
	rand_str = '';
	char_list = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~!@#$%^&*_+-=:;<>?,.|';
	char_length = char_list.length;
	for ( var i = 0; i < x; i++) {
		rand_str += char_list.charAt(Math.floor(Math.random() * char_length));
	}
	return rand_str;
	}
	"""

	# function for creating a random value containging special chars value of length x
	# Input: length of value
	# output: random string of length x (input)
	* def random_spchars =
	"""
	function(x) {
	rand_str = '';
	char_list = '~!@#$%^&*_+-=:;<>?,.|';
	char_length = char_list.length;
	for ( var i = 0; i < x; i++) {
		rand_str += char_list.charAt(Math.floor(Math.random() * char_length));
	}
	return rand_str;
	}
	"""

	# function for creating a random valid format GUID
	# found on stack overflow here - https://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
	# Input: none
	# Output: random GUID
	* def random_uuid =
	"""
	function() {
		return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		  var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		  return v.toString(16);
		});
	}
	"""

    * def isValidTime =
	"""
	function fn(s) {
		var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
		var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'");
		try {
			sdf.parse(s).time;
			return true;
		} catch(e) {
			karate.log('*** invalid date string:', s);
			return false;
		}
	}
	"""

	# function for getting the current date
	# Input: none
	# Output: current date in seconds 	
    * def getCurrentDate =
    """
		function() {
		var d = new Date();
		return d.getTime() / 1000;
		}
    """

	# function for creating a random service tag of 7 char length in format 'AAAAXXX'
	# Input: length of value
	# output: random string of length x (input)
	* def random_tag =
	"""
	function() {
	    var serverTag = random_string(4) + random_number(3);
        return serverTag.toUpperCase();
	}
	"""

Scenario: Generic Functions

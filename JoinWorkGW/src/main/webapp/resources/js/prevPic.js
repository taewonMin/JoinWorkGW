
function Preview_picture(fileName){
	
	var imageURL = "getPicture?picture="+fileName;
	$('div#pictureView').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'cover',
		'background-repeat':'no-repeat'
	});
	
}




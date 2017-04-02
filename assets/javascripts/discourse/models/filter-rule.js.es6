import RestModel from 'discourse/models/rest';

export default RestModel.extend({
	
	username1 : function() {
		return 'hi';
	}.property('username1')

});

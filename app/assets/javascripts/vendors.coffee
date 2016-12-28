# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	$('#vendor_vendor_services_attributes_0_service_id').parent().hide()
	vendor_service_types = $('#vendor_vendor_services_attributes_0_service_id').html()
	
	$('#vendor_vendor_type_id').change ->
		vendor_type = $('#vendor_vendor_type_id :selected').text()
		escaped_vendor_type = vendor_type.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
		options = $(vendor_service_types).filter("optgroup[label='#{escaped_vendor_type}']").html()
		if options
			$('#vendor_vendor_services_attributes_0_service_id').html(options)
			$('#vendor_vendor_services_attributes_0_service_id').parent().show()
		else
			$('#vendor_vendor_services_attributes_0_service_id').empty()
			$('#vendor_vendor_services_attributes_0_service_id').parent().hide()


jQuery ->
	$('#vendor_vendor_features_attributes_0_feature_id').parent().hide()
	vendor_feature_types = $('#vendor_vendor_features_attributes_0_feature_id').html()
	
	$('#vendor_vendor_type_id').change ->
		vendor_type = $('#vendor_vendor_type_id :selected').text()
		escaped_vendor_type = vendor_type.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
		options = $(vendor_feature_types).filter("optgroup[label='#{escaped_vendor_type}']").html()
		if options
			$('#vendor_vendor_features_attributes_0_feature_id').html(options)
			$('#vendor_vendor_features_attributes_0_feature_id').parent().show()
		else
			$('#vendor_vendor_features_attributes_0_feature_id').empty()
			$('#vendor_vendor_features_attributes_0_feature_id').parent().hide()



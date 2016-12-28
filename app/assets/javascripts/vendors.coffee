# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	vendor_service_types = $('#vendor_vendor_services_attributes_0_service_id').html()
	console.log(vendor_service_types)
	$('#vendor_vendor_type_id').change ->
		vendor_type = $('#vendor_vendor_type_id :selected').text()
		options = $(vendor_service_types).filter("optgroup[label='#{vendor_type}']").html()
		if options
			$('#vendor_vendor_services_attributes_0_service_id').html(options)
		else
			$('#vendor_vendor_services_attributes_0_service_id').empty()




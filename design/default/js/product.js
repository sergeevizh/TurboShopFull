(function ($) {
	"use strict";

	/*
	// Change Variant Color
	*/

	if ($("form.variants #colors").length) {
		$(function () {
			function changeColor() {
				var color = $('input[name=color]:checked'),
					arr = [];
				$('#colors label').removeClass('active');
				color.parent().addClass('active');
				$('#variants label').remove();
				$.each(variants, function (id, val) {
					if (val['color'] == color.val() && $.inArray(val['name'], arr) < 0) {
						arr.push(val['name']);
						$('#variants').append('<label class="btn btn-sm btn-outline-secondary mb-1 me-2"><input type="radio" name="variant" value="' + id + '" />' + val['name'] + '</label>');
					}
				});
				if (arr.length > 1) {
					$('#variants').show();
				} else {
					$('#variants').hide();
				}
				$("input[name=variant]:first").attr('checked', true).parent().addClass('active');
				changeVariant();
			}
			function changeVariant() {
				var variant = $('input[name=variant]:checked');
				var val = variants[variant.val()];
				var images_ids = val['images_ids'];
				var image_id = images_ids[0];
				var arr = [];
				if (images_ids.length > 0) {
					$('#product-slider-pagination div').hide();
				}
				if (image_id != '' && $('#image' + image_id) !== 'undefined') {
					$('#image' + image_id).find('a')[0].click();
					$.each(images_ids, function (id, val) { $('#image' + val).show(); });
				}
				$('#variants label').removeClass('active');
				variant.parent().addClass('active');
				$('.offers-price-old .price-value').text(val['compare_price']);
				$('.offers-price .price-value').text(val['price']);
				$('.article .value').html(val['sku']);
				var $availability = $('.availability');
				var $addToCart = $('#add-to-cart');
				var $fastOrder = $('#fast-order');
				if (val['stock'] < 1) {
					$availability.html($availability.data('stock')).removeClass('text-success').addClass('text-danger');
					$addToCart.attr('disabled', true);
					$fastOrder.addClass('disabled');
				} else {
					$availability.html($availability.data('default')).removeClass('text-danger').addClass('text-success');
					$addToCart.attr('disabled', false);
					$fastOrder.removeClass('disabled');
				}
			}

			$(document).ready(function () {
				$(document).on('change', '#colors input', function () { changeColor(); });
				$(document).on('change', '#variants input', function () { changeVariant(); });
				changeColor();
			});
		});
	}

	/*
	// Fast Order
	*/

	$(function () {
		$('.fast-order-send-button').click(function () {
			$("#fast-order-product-name").html($(this).data('name'));

			var variant;
			var form_obj = $(this).closest("form.variants");
			if (form_obj.find('input[name=variant]:checked').length > 0)
				variant = form_obj.find('input[name=variant]:checked').val();
			if (form_obj.find('select[name=variant]').length > 0)
				variant = form_obj.find('select').val();

			$("#fast-order-product-id").val(variant);

		});
	});

	/*
	// Carousel
	*/

	$(function () {
		$('[id^=carousel-selector-]').click(function () {
			var id_selector = $(this).attr("id");
			var id = id_selector.substr(id_selector.length - 1);
			id = parseInt(id);
			$('[id^=carousel-selector-]').removeClass('selected');
			$(this).addClass('selected');
		});
	});

	/*
	// Loader
	*/

	$(window).on("load", function () {
		$('.loader-container').fadeIn('slow');
	})

})(jQuery);		
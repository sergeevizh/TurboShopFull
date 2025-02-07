{if isset($order->id)}
	{$meta_title = "`$btr->global_order_number` `$order->id`" scope=global}
{else}
	{$meta_title = $btr->order_new scope=global}
{/if}

<form method="post" id="order" enctype="multipart/form-data" class="js-fast-button">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input name="id" type="hidden" value="{if isset($order->id)}{$order->id|escape}{/if}">
	<div class="d-inline-block me-3 mb-3">
		<h1 class="d-inline align-middle">
			{if isset($order->id)}
				{$btr->global_order_number|escape} {$order->id|escape}
			{else}
				{$btr->orders_add|escape}
			{/if}
		</h1>
	</div>
	<div class="d-grid d-sm-inline-block me-sm-3 me-0 mb-3">
		<select class="selectpicker" name="status">
			<option value='0' {if isset($order->status) && $order->status == 0}selected{/if}>{$btr->global_new_order|escape}</option>
			<option value='1' {if isset($order->status) && $order->status == 1}selected{/if}>{$btr->global_accepted_order|escape}</option>
			<option value='2' {if isset($order->status) && $order->status == 2}selected{/if}>{$btr->global_closed_order|escape}</option>
			<option value='3' {if isset($order->status) && $order->status == 3}selected{/if}>{$btr->global_canceled_order|escape}</option>
		</select>
	</div>
	{if isset($order->id)}
		<div class="d-none d-lg-inline-block d-inline-block me-3 mb-3" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->order_print|escape}">
			<a href="{url view=print id=$order->id}" target="_blank" class="heading-block text-dark">
				<i class="align-middle" data-feather="printer"></i>
			</a>
		</div>
		{if $labels}
			<div class="d-none d-lg-inline-block me-3 mb-3">
				<a class="nav-link dropdown-toggle order-dropdown-toggle" href="#" id="labelsDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">{$btr->global_select_label|escape}</a>
				<div class="dropdown-menu dropdown-menu-start js-labels-hide box-labels-hide" aria-labelledby="labelsDropdown">
					<ul class="option-labels-box">
						{foreach $labels as $l}
							<li class="js-ajax-labels badge d-block text-start my-2" data-order-id="{$order->id}" style="background-color: {$l->color|escape}">
								<input id="{$order->id}_{$l->id}" type="checkbox" class="d-none" name="order_labels[]" value="{$l->id}" {if in_array($l->id, $order_labels) && is_array($order_labels)}checked="" {/if}>
								<label for="{$order->id}_{$l->id}" class="cursor-pointer w-100"><span class="d-inline-block align-middle ms-3">{$l->name|escape}</span></label>
							</li>
						{/foreach}
					</ul>
				</div>
			</div>
			<div class="d-none d-lg-inline-block mb-3">
				<div class="js-ajax-label">
					{include file="labels_ajax.tpl"}
				</div>
			</div>
		{/if}
	{/if}
	{if isset($message_error)}
		<div class="row">
			<div class="col-12">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<div class="alert-message">
						{if $message_error=='error_closing'}
							{$btr->order_shortage|escape}
						{else}
							{$message_error|escape}
						{/if}
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</div>
			</div>
		</div>
	{elseif isset($message_success)}
		<div class="row">
			<div class="col-12">
				<div class="alert alert-success alert-dismissible fade show" role="alert">
					<div class="alert-message">
						{if $message_success=='updated'}
							{$btr->order_updated|escape}
						{elseif $message_success=='added'}
							{$btr->order_added|escape}
						{else}
							{$message_success|escape}
						{/if}
						{if $smarty.get.return}
							<a class="alert-link fw-normal btn-return text-decoration-none me-5" href="{$smarty.get.return}">
								<i class="align-middle mt-n1" data-feather="corner-up-left"></i>
								{$btr->global_back|escape}
							</a>
						{/if}
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</div>
			</div>
		</div>
	{/if}
	<div class="row gx-2">
		<div class="col-xl-12 col-xxl-8">
			<div class="card mh-230px">
				<div class="card-header">
					<div class="card-actions float-end">
						<div class="d-block d-lg-none position-relative collapse-icon">
							<a href="javascript:;" class="collapse-chevron">
								<i class="align-middle" data-feather="chevron-up"></i>
							</a>
						</div>
					</div>
					<h5 class="card-title mb-0">{$btr->order_content|escape}</h5>
				</div>
				<div class="collapse-card">
					<div class="card-body">
						<div id="js-purchase" class="turbo-list turbo-list-order">
							<div class="turbo-list-head">
								<div class="turbo-list-heading turbo-list-photo">{$btr->global_photo|escape}</div>
								<div class="turbo-list-heading turbo-list-order-name">{$btr->order_name_option|escape}</div>
								<div class="turbo-list-heading turbo-list-price">{$btr->global_price|escape} {$currency->sign|escape}</div>
								<div class="turbo-list-heading turbo-list-count">{$btr->global_qty|escape}, {$settings->units|escape}
								</div>
								<div class="turbo-list-heading turbo-list-order-amount-price">{$btr->global_sales_amount}</div>
							</div>
							<div class="turbo-list-body">
								{foreach $purchases as $purchase}
									<div class="js-row turbo-list-body-item purchases">
										<div class="turbo-list-row">
											<input type="hidden" name="purchases[id][{$purchase->id}]" value="{$purchase->id}">
											<div class="turbo-list-boding turbo-list-photo">
												{if isset($purchase->variant) && isset($purchase->product->images)}
													{$img_flag=0}
													{$image_array=","|explode:$purchase->variant->images_ids}
													{foreach $purchase->product->images as $image}
														{if $image->id|in_array:$image_array}
															{if $img_flag==0}{$image_toshow=$image}{/if}
															{$img_flag=1}
														{/if}
													{/foreach}
													{if $img_flag ne 0}
														<img src="{$image_toshow->filename|resize:50:50}" alt="{$purchase->product->name|escape}">
													{else}
														{$image = $purchase->product->images|first}
														{if $image}
															<img class="product-icon" src="{$image->filename|resize:50:50}" alt="{$purchase->product->name|escape}">
														{else}
															<i class="align-middle" data-feather="camera"></i>
														{/if}
													{/if}
												{/if}
											</div>
											<div class="turbo-list-boding turbo-list-order-name">
												<div class="d-inline-block me-3 mb-2">
													{if $purchase->product}
														<div class="mb-0"><a href="{url module=ProductAdmin id=$purchase->product->id}" class="fw-bold text-body text-decoration-none me-2">{$purchase->product_name|escape}</a></div>
														{if !$order->closed}
															{if !$purchase->product}
																<span class="text-danger" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->product_does_not_exist|escape}"><i class="align-middle mt-n1" data-feather="alert-circle"></i></span>
															{elseif !isset($purchase->variant)}
																<span class="text-danger" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->product_variant_does_not_exist|escape}"><i class="align-middle mt-n1" data-feather="alert-circle"></i></span>
															{elseif $purchase->variant->stock < $purchase->amount}
																<span class="text-danger" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->in_stock_left|escape} {$purchase->variant->stock}"><i class="align-middle mt-n1" data-feather="alert-circle"></i></span>
															{/if}
														{/if}
														{if $purchase->variant_name}
															<span class="text-secondary">{$btr->order_option|escape} {$purchase->variant_name|escape} {if isset($purchase->variant->color)}/ {$purchase->variant->color|escape}{/if}</span>
														{/if}
														{if $purchase->sku}
															<span class="text-secondary">/ {$btr->global_sku|escape} {$purchase->sku|default:"&mdash;"}</span>
														{/if}
													{else}
														<div class="text-secondary">{$purchase->product_name|escape}</div>
														{if $purchase->variant_name}
															<div class="text-secondary">{$btr->order_option|escape} {$purchase->variant_name|escape}</div>
														{/if}
														{if $purchase->sku}
															<div class="text-secondary">{$btr->global_sku|escape} {$purchase->sku|default:"&mdash;"}</div>
														{/if}
													{/if}
													<div class="d-block d-lg-none">
														<span class="text-primary fw-bold">{$purchase->price}</span>
														<span class="fw-bold">{$purchase->amount} {$settings->units|escape}</span>
													</div>
												</div>
												{if !isset($purchase->variant)}
													<input class="form-control" type="hidden" name="purchases[variant_id][{$purchase->id}]" value="">
												{else}
													<div class="d-inline-block">
														<select name="purchases[variant_id][{$purchase->id}]" class="selectpicker {if $purchase->product->variants|count == 1}d-none{/if} js-purchase-variant">
															{foreach $purchase->product->variants as $v}
																<option data-price="{$v->price}" data-amount="{$v->stock}" value="{$v->id}" {if $v->id == $purchase->variant_id}selected{/if}>
																	{if $v->name}
																		{$v->name|escape} {if $v->color}/ {$v->color|escape}{/if}
																	{else}
																		#{$v@iteration}
																	{/if}
																</option>
															{/foreach}
														</select>
													</div>
												{/if}
											</div>
											<div class="turbo-list-boding turbo-list-price">
												<div class="input-group">
													<input type="text" class="form-control js-purchase-price" name="purchases[price][{$purchase->id}]" value="{$purchase->price}">
													<span class="input-group-text">{$currency->sign}</span>
												</div>
											</div>
											<div class="turbo-list-boding turbo-list-count">
												<div class="input-group">
													<input class="form-control js-purchase-amount" type="text" name="purchases[amount][{$purchase->id}]" value="{$purchase->amount}">
													<span class="input-group-text">
														{$settings->units|escape}
													</span>
												</div>
											</div>
											<div class="turbo-list-boding turbo-list-order-amount-price">
												<div class="text-dark">
													<span>{($purchase->price*$purchase->amount)|number_format:2:".":""}</span>
													<span>{$currency->sign}</span>
												</div>
											</div>
											<div class="turbo-list-boding turbo-list-delete">
												<button type="button" class="btn-delete js-remove-item" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->global_delete|escape}">
													<i class="align-middle" data-feather="trash-2"></i>
												</button>
											</div>
										</div>
									</div>
								{/foreach}
							</div>
							<div class="js-row turbo-list-body-item js-new_purchase" style="display: none">
								<div class="turbo-list-row">
									<div class="turbo-list-boding turbo-list-photo">
										<input type="hidden" name="purchases[id][]" value="">
										<img class="js-new-image" src="">
									</div>
									<div class="turbo-list-boding turbo-list-order-name">
										<div class="d-inline-block">
											<a class="js-new-product fw-bold text-body text-decoration-none me-2" href=""></a>
											<div class="js-new-variant-name"></div>
										</div>
										<div class="d-inline-block">
											<select name="purchases[variant_id][]" class="js-new-variant"></select>
										</div>
									</div>
									<div class="turbo-list-boding turbo-list-price">
										<div class="input-group">
											<input type="text" class="form-control js-purchase-price" name="purchases[price][]" value="">
											<span class="input-group-text">{$currency->sign|escape}</span>
										</div>
									</div>
									<div class="turbo-list-boding turbo-list-count">
										<div class="input-group">
											<input class="form-control js-purchase-amount" type="text" name="purchases[amount][]" value="1">
											<span class="input-group-text">
												{$settings->units|escape}
											</span>
										</div>
									</div>
									<div class="turbo-list-boding turbo-list-order-amount-price">
										<div class="text-dark">
											{if isset($purchase->price)}
												<span>{$purchase->price}</span>
												<span>{$currency->sign|escape}</span>
											{/if}
										</div>
									</div>
									<div class="turbo-list-boding turbo-list-delete">
										<button type="button" class="btn-delete js-remove-item" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->global_delete|escape}">
											<i class="align-middle" data-feather="trash-2"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-lg-6 col-md-12 mb-1">
								<div class="autocomplete-arrow">
									<input type="text" name="new_purchase" id="js-add-purchase" class="form-control" placeholder="{$btr->global_add_product|escape}">
								</div>
							</div>
							<div class="col-lg-6 col-md-12">
								{if $purchases}
									<div class="text-dark fw-bold text-end me-1 mt-2">
										<div class="h3">{$btr->global_total|escape}: {$subtotal|number_format:2:".":""} {$currency->sign|escape}</div>
									</div>
								{/if}
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="card mh-230px">
				<div class="card-header">
					<div class="card-actions float-end">
						<div class="d-block d-lg-none position-relative collapse-icon">
							<a href="javascript:;" class="collapse-chevron">
								<i class="align-middle" data-feather="chevron-up"></i>
							</a>
						</div>
					</div>
					<h5 class="card-title mb-0">{$btr->order_parameters|escape}</h5>
				</div>
				<div class="collapse-card">
					<div class="card-body">
						<div class="turbo-list turbo-list-order">
							<div class="turbo-list-body">
								<div class="turbo-list-body-item">
									<div class="turbo-list-row d-md-flex d-block">
										<div class="turbo-list-boding turbo-turbo-list-order-content-name">
											{$btr->global_discount|escape}
										</div>
										<div class="turbo-list-boding turbo-list-order-content-val">
											<div class="input-group">
												<input type="text" class="form-control" name="discount" value="{if isset($order->discount)}{$order->discount}{/if}">
												<span class="input-group-text">%</span>
											</div>
										</div>
										<div class="turbo-list-boding turbo-list-order-content-price">
											<span>{if isset($order->discount)}{($subtotal-$subtotal*$order->discount/100)|number_format:2:".":""}{/if}</span>
											<span>{$currency->sign|escape}</span>
										</div>
									</div>
								</div>
								<div class="turbo-list-body-item">
									<div class="turbo-list-row d-md-flex d-block">
										<div class="turbo-list-boding turbo-turbo-list-order-content-name">
											{$btr->global_coupon|escape} {if isset($order->coupon_code) && $order->coupon_code}({$order->coupon_code}){/if}
										</div>
										<div class="turbo-list-boding turbo-list-order-content-val">
											<div class="input-group">
												<input type="text" class="form-control" name="coupon_discount" value="{if isset($order->coupon_discount)}&minus;{$order->coupon_discount}{/if}">
												<span class="input-group-text">{$currency->sign|escape}</span>
											</div>
										</div>
										<div class="turbo-list-boding turbo-list-order-content-price">
											<span>{if isset($order->discount)}{($subtotal-$subtotal*$order->discount/100-$order->coupon_discount)|number_format:2:".":""}{/if}</span>
											<span>{$currency->sign|escape}</span>
										</div>
									</div>
								</div>
								<div class="turbo-list-body-item">
									<div class="turbo-list-row d-md-flex d-block">
										<div class="turbo-list-boding turbo-turbo-list-order-content-name">
											{$btr->global_weight|escape}
										</div>
										<div class="turbo-list-boding turbo-list-order-content-val">
											<div class="input-group">
												<input type="text" class="form-control" name="weight" value="{if isset($order->weight)}{$order->weight}{/if}">
												<span class="input-group-text">{$settings->weight_units}</span>
											</div>
										</div>
									</div>
								</div>
								<div class="turbo-list-body-item">
									<div class="turbo-list-row d-md-flex d-block">
										<div class="turbo-list-boding turbo-turbo-list-order-content-name">
											<div class="d-inline-block form-label me-2">{$btr->global_shipping|escape}</div>
											<div class="d-inline-block">
												<select name="delivery_id" class="selectpicker">
													<option value="0">{$btr->order_not_selected|escape}</option>
													{foreach $deliveries as $d}
														<option value="{$d->id}" {if isset($delivery) && $d->id==$delivery->id}selected{/if}>{$d->name|escape}</option>
													{/foreach}
												</select>
											</div>
										</div>
										<div class="turbo-list-boding turbo-list-order-content-val">
											<div class="input-group">
												<input type="text" name="delivery_price" class="form-control" value="{if isset($order->delivery_price)}{$order->delivery_price}{/if}">
												<span class="input-group-text">{$currency->sign|escape}</span>
											</div>
										</div>
										<div class="turbo-list-boding turbo-list-order-content-price">
											<div class="form-check d-inline-block align-top mt-1" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->global_paid_separately|escape}">
												<input class="form-check-input" type="checkbox" id="separate-delivery" name="separate_delivery" value="1" {if isset($order->separate_delivery) && $order->separate_delivery}checked{/if}>
												<label class="form-check-label" for="separate-delivery"></label>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-4 col-md-12 mt-2">
								<div class="form-label">{$btr->global_payment|escape}</div>
								<div class="mt-1">
									<select name="payment_method_id" class="selectpicker">
										<option value="0">{$btr->order_not_selected|escape}</option>
										{foreach $payment_methods as $pm}
											<option value="{$pm->id}" {if isset($payment_method) && $pm->id==$payment_method->id}selected{/if}>{$pm->name|escape}</option>
										{/foreach}
									</select>
								</div>
							</div>
							<div class="col-lg-8 col-md-12">
								<div class="text-dark fw-bold text-end mt-3">
									<div class="h3">{$btr->global_total|escape}: {if isset($order->total_price)}{$order->total_price}{/if} {$currency->sign|escape}</div>
								</div>
								<div class="fw-bold text-end me-1 mt-1">
									{if isset($payment_method)}
										<div class="h3 text-secondary">{$btr->order_to_pay|escape} {$order->total_price|convert:$payment_currency->id} {$payment_currency->sign}</div>
									{/if}
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="form-check form-switch form-check-reverse float-start mt-3">
									<input class="paid form-check-input" type="checkbox" id="paid" name="paid" value="1" {if isset($order->paid) && $order->paid}checked=""{/if}>
									<label class="form-check-label me-2" for="paid">{$btr->order_paid|escape}</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-12 col-xxl-4">
			<div class="card mh-230px">
				<div class="card-header">
					<div class="card-actions float-end">
						<div class="d-block d-lg-none position-relative collapse-icon">
							<a href="javascript:;" class="collapse-chevron">
								<i class="align-middle" data-feather="chevron-up"></i>
							</a>
						</div>
					</div>
					<h5 class="card-title mb-0">{$btr->global_buyer_information|escape}</h5>
				</div>
				<div class="collapse-card">
					<div class="card-body">
						<div class="mb-3">
							<label class="form-label d-inline-block">{$btr->order_date|escape}</label>
							<div class="d-inline-block text-dark fw-bold">{if isset($order->date)}{$order->date|date} {$order->date|time}{/if}</div>
						</div>
						<div class="mb-3">
							<label class="form-label" for="name">{$btr->global_full_name|escape}</label>
							<input name="name" class="form-control" id="name" type="text" value="{if isset($order->name)}{$order->name|escape}{/if}">
						</div>
						<div class="mb-3">
							<label class="form-label" for="phone">{$btr->global_phone|escape}</label>
							<input name="phone" class="form-control" id="phone" ype="text" value="{if isset($order->phone)}{$order->phone|escape}{/if}">
						</div>
						<div class="mb-3">
							<label class="form-label" for="email">E-mail</label>
							<input name="email" class="form-control" id="email" type="text" value="{if isset($order->email)}{$order->email|escape}{/if}">
						</div>
						<div class="mb-3">
							<label class="form-label">{$btr->global_address|escape} <i class="align-middle text-secondary" data-feather="map"></i> <a href="https://www.google.com/maps/search/{$order->address|escape}?hl={$settings->lang}" target="_blank">{$btr->order_on_map|escape}</a></label>
							<textarea name="address" class="form-control short-textarea">{if isset($order->address)}{$order->address|escape}{/if}</textarea>
						</div>
						<div class="mb-3">
							<label class="form-label">{$btr->global_comment|escape}</label>
							<textarea name="comment" class="form-control short-textarea">{if isset($order->comment)}{$order->comment|escape}{/if}</textarea>
						</div>
						{if isset($order->ip)}
							<div class="mb-3">
								<label class="form-label d-inline-block">{$btr->order_ip|escape} <i class="align-middle text-secondary" data-feather="map-pin"></i> <a href="https://who.is/whois-ip/ip-address/{$order->ip}" target="_blank"> whois</a></label>
								<div class="d-inline-block text-dark fw-bold">{$order->ip|escape}</div>
							</div>
						{/if}
						<div class="mb-3">
							{if !isset($user)}
								<hr>
								<label class="form-label">
									{$btr->global_buyer_not_registred|escape}
								</label>
								<input type="hidden" name="user_id" value="{if isset($user->id)}{$user->id}{/if}">
								<input type="text" class="js-user-complite form-control" placeholder="{$btr->order_user_select|escape}">
								<hr>
							{else}
								<div class="js-user-row">
									<hr>
									<label class="form-label">
										{$btr->global_buyer|escape}:
										<a href="{url module=UserAdmin id=$user->id}" target="_blank" class="me-1">
											{$user->name|escape}
										</a>
										<a href="javascript:;" class="js-edit-user btn-edit text-body text-decoration-none" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->global_edit|escape}">
											<i class="align-middle" data-feather="edit"></i>
										</a>
										<a href="javascript:;" class="js-delete-user btn-delete mt-n1" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->users_delete|escape}">
											<i class="align-middle" data-feather="trash-2"></i>
										</a>
									</label>
									{if $user->group_id > 0}
										<div class="text-secondary">{$user->group->name|escape}</div>
									{else}
										<div class="text-secondary">{$btr->order_not_in_group|escape}</div>
									{/if}
									<hr>
								</div>
								<div class="edit-user mb-3" style="display:none;">
									<label class="form-label">
										{$btr->global_buyer|escape}
									</label>
									<input type="hidden" name="user_id" value="{if isset($user->id)}{$user->id}{/if}">
									<input type="text" class="js-user-complite form-control" placeholder="{$btr->order_user_select|escape}">
								</div>
							{/if}
						</div>
						<div class="mb-3">
							<label class="form-label">{$btr->order_language|escape}</label>
							<select name="lang_id" class="selectpicker">
								{foreach $languages as $l}
									<option value="{$l->id}" {if isset($order->lang_id) && $l->id == $order->lang_id}selected{/if} data-content='<span class="flag-icon flag-icon-{$l->label}"></span> {$l->name|escape}'>{$l->name|escape}</option>
								{/foreach}
							</select>
						</div>
						<div class="mb-3">
							<label class="form-label">{$btr->order_note|escape}</label>
							<textarea name="note" class="form-control short-textarea">{if isset($order->note)}{$order->note|escape}{/if}</textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12 mt-3">
			<div class="d-grid d-sm-block">
				<button type="submit" class="btn btn-primary float-end">
					<i class="align-middle" data-feather="check"></i>
					<span>{$btr->global_apply|escape}</span>
				</button>
				<label class="form-check float-end mt-3 mt-sm-1">
					<input class="form-check-input" type="checkbox" name="notify_user" value="1">
					<span class="form-check-label align-middle ms-2 me-3">
						{$btr->order_email|escape}
					</span>
				</label>
			</div>
		</div>
	</div>
</form>

{* Autocomplete *}
{js id="autocomplete" priority=99 include=["turbo/design/js/autocomplete/jquery.autocomplete-min.js"]}{/js}
{javascript minify=true}

{* Flag icon *}
{css id="flag" include=["turbo/design/css/flag-icon.min.css"]}{/css}
{stylesheet minify=true}

{literal}
	<script>
		$(window).on("load", function() {
			$(document).on("click", "#js-purchase .js-remove-item", function() {
				$(this).closest(".js-row").fadeOut(200, function() { $(this).remove(); });
				return false;
			});

			$(document).on("change", ".js-ajax-labels input", function () {
				elem = $(this);
				var order_id = parseInt($(this).closest(".js-ajax-labels").data("order-id"));
				var state = "";
				session_id = '{/literal}{$smarty.session.id}{literal}';
				var label_id = parseInt($(this).closest(".js-ajax-labels").find("input").val());
				if ($(this).closest(".js-ajax-labels").find("input").is(":checked")) {
					state = "add";
				} else {
					state = "remove";
				}
				$.ajax({
					type: "POST",
					dataType: 'json',
					url: "ajax/update_order.php",
					data: {
						order_id: order_id,
						state: state,
						label_id: label_id,
						session_id: session_id
					},
					success: function (data) {
						var msg = "";
						if (data) {
							$(".js-ajax-label").html(data.data);
							notyf.success({ message: '{/literal}{$btr->global_success|escape}{literal}', dismissible: true });
						} else {
							notyf.error({ message: '{/literal}{$btr->global_error|escape}{literal}', dismissible: true });
						}
					}
				});
			});

			var new_purchase = $('#js-purchase .js-new_purchase').clone(true);
			$('#js-purchase .js-new_purchase').remove().removeAttr('class');
			$("#js-add-purchase").autocomplete({
				serviceUrl: 'ajax/add_order_product.php',
				minChars: 0,
				maxHeight: 353,
				noCache: false,
				onSelect: function(suggestion) {
					new_item = new_purchase.clone().appendTo('#js-purchase .turbo-list-body');
					new_item.removeAttr('id');
					new_item.find('.js-new-product').html(suggestion.data.name);
					new_item.find('.js-new-product').attr('href', 'index.php?module=ProductAdmin&id=' + suggestion.data.id);
					var variants_select = new_item.find("select.js-new-variant");
					for (var i in suggestion.data.variants) {
						variants_select.append("<option value='" + suggestion.data.variants[i].id + "' data-price='" + suggestion.data.variants[i].price + "' data-amount='" + suggestion.data.variants[i].stock + "'>" + suggestion.data.variants[i].name + "  " + suggestion.data.variants[i].color + "</option>");
					}
					if (suggestion.data.variants.length > 1 || suggestion.data.variants[0].name != '') {
						variants_select.show();
						variants_select.selectpicker();
					} else {
						variants_select.hide();
					}
					variants_select.find('option:first').attr('selected', true);
					variants_select.bind('change', function() {
						change_variant(variants_select);
					});
					change_variant(variants_select);
					if (suggestion.data.image) {
						new_item.find('.js-new-image').attr("src", suggestion.data.image);
					} else {
						new_item.find('.js-new-image').remove();
					}
					$("input#js-add-purchase").val('').focus().blur();
					new_item.show();
				},
				formatResult: function(suggestions, currentValue) {
					var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
					var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
					return "<div>" + (suggestions.data.image ? "<img align=absmiddle src='" + suggestions.data.image + "'> " : '') + "</div>" + "<span>" + suggestions.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>') + "</span>";
				}
			});

			function change_variant(element) {
				var price = element.find('option:selected').data('price');
				var amount = element.find('option:selected').data('amount');
				element.closest('.js-row').find('input.js-purchase-price').val(price);
				var amount_input = element.closest('.js-row').find('input.js-purchase-amount');
				amount_input.val('1');
				amount_input.data('max', amount);
				return false;
			}

			$(".js-user-complite").autocomplete({
				serviceUrl: 'ajax/search_users.php',
				minChars: 0,
				noCache: false,
				onSelect: function(suggestion) {
					$('input[name="user_id"]').val(suggestion.data.id);
				},
				formatResult: function(suggestions, currentValue) {
					var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
					var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
					return "<span>" + suggestions.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>') + "</span>";
				}
			});

			$(document).on("click", ".js-delete-user", function() {
				$(this).closest(".js-user-row").hide();
				$('input[name="user_id"]').val(0);
			});

			$(document).on("click", ".js-edit-user", function() {
				$(".js-user-row").hide();
				$(".edit-user").show();
				return false;
			});

			$("select.js-purchase-variant").bind("change", function() {
				change_variant($(this));
			});
		});
	</script>
{/literal}
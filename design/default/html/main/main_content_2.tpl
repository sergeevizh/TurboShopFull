{* Featured Products *}
{get_featured_products var=featured_products limit=4}
{if $featured_products}
	<div class="section-heading">
		<a href="{$lang_link}featured" class="btn btn-outline-primary float-end">
			{$lang->see_all}
			<i class="fal fa-chevron-right ms-2"></i>
		</a>
		<h2 class="section-title my-2">{$lang->featured_products}</h2>
	</div>
	<hr class="text-black-50">
	<div class="row">
		{foreach $featured_products as $product}
			<div class="col-md-6 col-lg-4 col-xl-3">
				{include file='products/grid.tpl'}
			</div>
		{/foreach}
	</div>
{/if}

{* New Products *}
{get_is_new_products var=new_products limit=4}
{if $new_products}
	<div class="section-heading">
		<a href="{$lang_link}new" class="btn btn-outline-primary float-end">
			{$lang->see_all}
			<i class="fal fa-chevron-right ms-2"></i>
		</a>
		<h2 class="section-title my-2">{$lang->new_arrivals}</h2>
	</div>
	<hr class="text-black-50">
	<div class="row">
		{foreach $new_products as $product}
			<div class="col-md-6 col-lg-4 col-xl-3">
				{include file='products/grid.tpl'}
			</div>
		{/foreach}
	</div>
{/if}

{* Discounted Products *}
{get_discounted_products var=discounted_products limit=4}
{if $discounted_products}
	<div class="section-heading">
		<a href="{$lang_link}sale" class="btn btn-outline-primary float-end">
			{$lang->see_all}
			<i class="fal fa-chevron-right ms-2"></i>
		</a>
		<h2 class="section-title my-2">{$lang->sale}</h2>
	</div>
	<hr class="text-black-50">
	<div class="row">
		{foreach $discounted_products as $product}
			<div class="col-md-6 col-lg-4 col-xl-3">
				{include file='products/grid.tpl'}
			</div>
		{/foreach}
	</div>
{/if}

{* Hit *}
{get_is_hit_products var=hit_products limit=4}
{if $hit_products}
	<div class="section-heading">
		<a href="{$lang_link}hit" class="btn btn-outline-primary float-end">
			{$lang->see_all}
			<i class="fal fa-chevron-right ms-2"></i>
		</a>
		<h2 class="section-title my-2">{$lang->bestsellers}</h2>
	</div>
	<hr class="text-black-50">
	<div class="row">
		{foreach $hit_products as $product}
			<div class="col-md-6 col-lg-4 col-xl-3">
				{include file='products/grid.tpl'}
			</div>
		{/foreach}
	</div>
{/if}

{* Featured Categories *}
{get_featured_categories var=featured_categories}
{if $featured_categories}
	<h2 class="my-2">{$lang->popular_categories}</h2>
	<hr class="text-black-50">
	<div class="row">
		{foreach $categories as $c}
			{if $c->featured}
				{if $c->visible}
					<div class="col-lg-3 col-md-6 mb-4">
						<div class="card">
							<div class="img-wrap">
								{if $c->image}
									<div class="image">
										<a href="{$lang_link}catalog/{$c->url}">
											<img class="card-img-top" src="{$c->image|resize_catalog:240:240}" alt="{$c->name}">
										</a>
									</div>
								{else}
									<div class="image">
										<a href="{$lang_link}catalog/{$c->url}">
											<img style="width: 170px; height: 170px;" src="design/{$settings->theme|escape}/images/no-photo.svg" alt="{$c->name}">
										</a>
									</div>
								{/if}
							</div>
							<div class="card-body">
								<div class="h5 card-title"><a data-category="{$c->id}" class="text-decoration-none" href="{$lang_link}catalog/{$c->url}">
										{if $c->code}<i class="fal fa-{$c->code|escape} me-1"></i>{/if}
										{$c->name|escape}
									</a>
								</div>
							</div>
							{if isset($c->subcategories) && $c->subcategories}
								<ul id="featured-categories" class="list-group list-group-flush">
									{foreach $c->subcategories as $cs}
										{if $cs->featured}
											{if $cs->visible}
												<li class="list-group-item">
													<a data-category="{$cs->id}" href="{$lang_link}catalog/{$cs->url}" class="text-decoration-none">
														{if $cs->code}<i class="fal fa-{$cs->code|escape} me-1"></i>{/if}
														{$cs->name}
													</a>
												</li>
											{/if}
										{/if}
									{/foreach}
								</ul>
							{/if}
						</div>
					</div>
				{/if}
			{/if}
		{/foreach}
	</div>
{/if}
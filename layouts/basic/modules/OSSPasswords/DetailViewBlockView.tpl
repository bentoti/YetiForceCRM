{*<!-- {[The file is published on the basis of YetiForce Public License 3.0 that can be found in the following directory: licenses/LicenseEN.txt or yetiforce.com]} -->*}
{strip}
	{foreach key=BLOCK_LABEL_KEY item=FIELD_MODEL_LIST from=$RECORD_STRUCTURE}
		{assign var=BLOCK value=$BLOCK_LIST[$BLOCK_LABEL_KEY]}
	{if $BLOCK eq null or $FIELD_MODEL_LIST|@count lte 0}{continue}{/if}
	{assign var=BLOCKS_HIDE value=$BLOCK->isHideBlock($RECORD,$VIEW)}
	{assign var=IS_HIDDEN value=$BLOCK->isHidden()}
	{assign var=WIDTHTYPE value=$USER_MODEL->get('rowheight')}
	{if $BLOCKS_HIDE}
		<div class="detailViewTable">
			<div class="panel panel-default row no-margin" data-label="{$BLOCK_LABEL}">					
				<div class="row blockHeader panel-heading no-margin">
					<div class="iconCollapse">
						<span class="cursorPointer blockToggle fas fa-angle-right {if !($IS_HIDDEN)}hide{/if}" alt="{\App\Language::translate('LBL_EXPAND_BLOCK')}" data-mode="hide" data-id={$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}></span>
						<span class="cursorPointer blockToggle fas fa-angle-down {if $IS_HIDDEN}hide{/if}" alt="{\App\Language::translate('LBL_COLLAPSE_BLOCK')}" data-mode="show" data-id={$BLOCK_LIST[$BLOCK_LABEL_KEY]->get('id')}></span>
						<h4>{\App\Language::translate({$BLOCK_LABEL_KEY},{$MODULE_NAME})}</h4>
					</div>
				</div>
				<div class="col-12 noSpaces panel-body blockContent {if $IS_HIDDEN} hide{/if}">
					{assign var=COUNTER value=0}
					<div class="col-12 paddingLRZero fieldRow">
						{foreach item=FIELD_MODEL key=FIELD_NAME from=$FIELD_MODEL_LIST}
							{if !$FIELD_MODEL->isViewableInDetailView()}
								{continue}
							{/if}
							{if $FIELD_MODEL->getUIType() eq "69" || $FIELD_MODEL->getUIType() eq "105"}
								{if $COUNTER neq 0}
									{if $COUNTER eq 2}
									</div><div class="col-12 paddingLRZero fieldRow">
										{assign var=COUNTER value=0}
									{/if}
								{/if}
								<div class="col-md-6 col-12 fieldsLabelValue paddingLRZero"
									 <div class="fieldLabel col-sm-5 col-12 {$WIDTHTYPE}">
										<label class="muted pull-left-xs pull-right-sm pull-right-md pull-right-lg">{\App\Language::translate({$FIELD_MODEL->getFieldLabel()},{$MODULE_NAME})}</label>
									</div>
									<div class="fieldValue col-sm-7 col-12 {$WIDTHTYPE}">
										<div id="imageContainer">
											{foreach key=ITER item=IMAGE_INFO from=$IMAGE_DETAILS}
												{if !empty($IMAGE_INFO.path) && !empty({$IMAGE_INFO.orgname})}
													<img src="data:image/jpg;base64,{base64_encode(file_get_contents($IMAGE_INFO.path))}" width="300" height="200">
												{/if}
											{/foreach}
										</div>
									</div>
								</div>
								{assign var=COUNTER value=$COUNTER+1}
							{else}
								{if $FIELD_MODEL->getUIType() eq "20" or $FIELD_MODEL->getUIType() eq "19"}
									{if $COUNTER eq '1'}
										{assign var=COUNTER value=0}
									{/if}
								{/if}
								{if $COUNTER eq 2}
								</div><div class="col-12 paddingLRZero fieldRow">
									{assign var=COUNTER value=1}
								{else}
									{assign var=COUNTER value=$COUNTER+1}
								{/if}
								<div class="col-md-6 col-12 fieldsLabelValue paddingLRZero">
									<div class="fieldLabel col-sm-5 col-12 {$WIDTHTYPE}" id="{$MODULE}_detailView_fieldLabel_{$FIELD_MODEL->getName()}">
										<label class="muted pull-left-xs pull-right-sm pull-right-md pull-right-lg">
											{\App\Language::translate({$FIELD_MODEL->getFieldLabel()},{$MODULE_NAME})}
										</label>
									</div>
									<div class="fieldValue col-sm-7 col-12 {$WIDTHTYPE}" id="{$MODULE}_detailView_fieldValue_{$FIELD_MODEL->getName()}" {if $FIELD_MODEL->getUIType() eq '19' or $FIELD_MODEL->getUIType() eq '20'} {assign var=COUNTER value=$COUNTER+1} {/if} {if $FIELD_MODEL->getName() eq 'password'}onclick="showPasswordQuickEdit('{$smarty.get.record}');" {/if}>
										<span class="value" data-field-type="{$FIELD_MODEL->getFieldDataType()}" {if $FIELD_MODEL->getName() eq 'password'}id="detailPassword" {/if}>
											{include file=\App\Layout::getTemplatePath($FIELD_MODEL->getUITypeModel()->getDetailViewTemplateName(), $MODULE_NAME) FIELD_MODEL=$FIELD_MODEL USER_MODEL=$USER_MODEL MODULE=$MODULE_NAME RECORD=$RECORD}
										</span>
										{if $FIELD_MODEL->isEditable() eq 'true' && ($FIELD_MODEL->getFieldDataType()!=Vtiger_Field_Model::REFERENCE_TYPE) && $IS_AJAX_ENABLED && $FIELD_MODEL->isAjaxEditable() eq 'true'}
											<span class="hide edit">
												{include file=\App\Layout::getTemplatePath($FIELD_MODEL->getUITypeModel()->getTemplateName(), $MODULE_NAME) FIELD_MODEL=$FIELD_MODEL USER_MODEL=$USER_MODEL MODULE=$MODULE_NAME}
												{if $FIELD_MODEL->getFieldDataType() eq 'boolean' || $FIELD_MODEL->getFieldDataType() eq 'picklist'}
													<input type="hidden" class="fieldname" data-type="{$FIELD_MODEL->getFieldDataType()}" value='{$FIELD_MODEL->getName()}' data-prev-value='{$FIELD_MODEL->get('fieldvalue')}' />		
												{else}
													{assign var=FIELD_VALUE value=$FIELD_MODEL->getEditViewDisplayValue($FIELD_MODEL->get('fieldvalue'), $RECORD)}
													{if $FIELD_VALUE|is_array}
														{assign var=FIELD_VALUE value=\App\Json::encode($FIELD_VALUE)}
													{/if}
													<input type="hidden" class="fieldname" value='{$FIELD_MODEL->getName()}' data-type="{$FIELD_MODEL->getFieldDataType()}" data-prev-value='{\App\Purifier::encodeHtml($FIELD_VALUE)}' />
												{/if}
											</span>
										{/if}
									</div>
								</div>
							{/if}
						{/foreach}
					</div>
				</div>
			</div>
		{/if}
	{/foreach}    

    <div class="contentHeader row no-margin">
        <div class="float-right">
            <button class="btn btn-success hide" data-copy-target="detailPassword" id="copy-button" type="button" title="{\App\Language::translate('LBL_CopyToClipboardTitle', $MODULE_NAME)}"><span class="fas fa-copy"></span> {\App\Language::translate('LBL_CopyToClipboard', $MODULE_NAME)}</button>&nbsp;&nbsp;
            <button class="btn btn-warning" onclick="showDetailsPassword('{$smarty.get.record}');return false;" id="show-btn">{\App\Language::translate('LBL_ShowPassword', $MODULE_NAME)}</button>
        </div>
        <div class="clearfix"></div>
    </div>
{/strip}

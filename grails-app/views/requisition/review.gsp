
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        <g:set var="entityName" value="${warehouse.message(code: 'requisition.label', default: 'Requisition').toLowerCase()}" />
        <title><warehouse:message code="default.review.label" args="[entityName]" /></title>
        <style>
            .selected { color: #666; }
            .unselected { color: #ccc; }
        </style>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
	            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
            
                <g:render template="summary" model="[requisition:requisition]"/>


                <div class="yui-gd">
                    <div class="yui-u first">
                        <g:render template="header" model="[requisition:requisition]"/>
                    </div>
                    <div class="yui-u">
                        <div id="tabs-details" class="box">
                            <h3>
                                <warehouse:message code="requisition.review.label"/>
                            </h3>
                            <table>
                                <thead>
                                    <tr class="odd">
                                        <th><warehouse:message code="default.status.label" default="Status"/></th>
                                        <%--
                                        <th class="center">
                                            <g:checkBox name="selectAll" class="selectAll"/>
                                        </th>
                                        --%>
                                        <th>
                                            <warehouse:message code="requisitionItem.product.label" /> /
                                            <warehouse:message code="requisitionItem.productPackage.label" />
                                        </th>
                                        <th class="center">
                                            <warehouse:message code="requisitionItem.quantity.label" />
                                        </th>
                                        <th class="center">
                                            <warehouse:message code="requisitionItem.quantityCanceled.label" />
                                        </th>
                                        <th class="center">
                                            <warehouse:message code="default.quantityOnHand.label" />
                                        </th>
                                        <%--
                                        <th class="right">
                                            <warehouse:message code="default.quantityAvailableToPromise.label" />
                                        </th>
                                        --%>
                                        <th class='center'>
                                            <warehouse:message code="default.actions.label"/>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:if test="${requisition?.requisitionItems?.size() == 0}">
                                        <tr class="prop odd">
                                            <td colspan="8" class="center"><warehouse:message
                                                    code="requisition.noRequisitionItems.message" /></td>
                                        </tr>
                                    </g:if>
                                    <g:each var="requisitionItem"
                                        in="${requisition?.requisitionItems.findAll { !it.parentRequisitionItem }}" status="i">
                                        <g:render template="reviewRequisitionItem" model="[requisitionItem:requisitionItem, i:i]"/>
                                        <g:each var="childRequisitionItem" in="${requisitionItem?.requisitionItems}">
                                            <g:render template="reviewRequisitionItem" model="[requisition:requisition,requisitionItem:childRequisitionItem, i:i, isChild:true]"/>
                                        </g:each>

                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                        <div class="clear"></div>
                        <div class="buttons">
                            <div class="center">
                                <g:link controller="requisition" action="edit" id="${requisition.id }" class="button">
                                    <warehouse:message code="default.button.back.label"/>
                                </g:link>

                                <g:link controller="requisition" action="pick" id="${requisition.id }" class="button">
                                    <warehouse:message code="default.button.next.label"/>
                                </g:link>
                            </div>
                        </div>
			        </div>
                </div>
            </div>
		</div>
		<script type="text/javascript">
			$(function() {
				$(".selectAll").click(function() {
					var thisCheck = $(this);
					if (thisCheck.is(':checked')) {
						$(".selectItem").attr("checked", true);
					}
					else {
						$(".selectItem").attr("checked", false);
					}
				});
			}); 		
		</script>
            
    </body>
</html>

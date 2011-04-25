	<#if (actionErrors?exists && actionErrors?size>0)> 
		<div id="SystemErrorMessage" style="top: 20px">
			<#list actionErrors as actionError>
				<span >${actionError?if_exists}</span><br/>
			</#list>
		</div>
	</#if>
	<#if (actionMessages?exists && actionMessages?size>0)> 
		<div id="SystemErrorMessage" style="top: 20px">
			<#list actionMessages as actionMessage>
				<span >${actionMessage?if_exists}</span><br/>
			</#list>
		</div>
	</#if>
	<#if (fieldErrors?exists && fieldErrors?size>0)> 
		<div id="SystemErrorMessage" style="top: 20px">
			<#list fieldErrors as fieldError>
				<span >${fieldError?if_exists}</span><br/>
			</#list>
		</div>
	</#if>
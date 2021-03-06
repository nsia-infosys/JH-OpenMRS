<%	
	ui.includeJavascript("coreapps", "fragments/patientdashboard/encountertemplate/defaultEncounterTemplate.js")
%>

<script type="text/template" id="defaultEncounterTemplate">
<li>
	<div class="encounter-date">
	    <i class="icon-time"></i>
	    <strong>
	        {{- encounter.encounterTime }}
	    </strong>
	    {{- encounter.encounterDate }}
	</div>
	<ul class="encounter-details">
	    <li> 
	        <div class="encounter-type">
	            <strong>
	                <i class="{{- config.icon }}"></i>
	                <span class="encounter-name" data-encounter-id="{{- encounter.encounterId }}">{{- encounter.encounterType.name }}</span>
	            </strong>
	        </div>
	    </li>
	    <li>
	        <div>
	            ${ ui.message("coreapps.by") }
	            <strong class="provider">
	                {{- encounter.primaryProvider ? encounter.primaryProvider : '' }}
	            </strong>
	            ${ ui.message("coreapps.in") }
	            <strong class="location">{{- encounter.location }}</strong>
	        </div>
	    </li>
	    <li>
	        <div class="details-action">
	            <a class="view-details collapsed" href='javascript:void(0);' data-encounter-id="{{- encounter.encounterId }}" data-encounter-form="{{- encounter.form != null}}" data-display-with-html-form="{{- config.displayWithHtmlForm }}" data-target="#encounter-summary{{- encounter.encounterId }}" data-toggle="collapse" data-target="#encounter-summary{{- encounter.encounterId }}">
	                <span class="show-details">${ ui.message("coreapps.patientDashBoard.showDetails")}</span>
	                <span class="hide-details">${ ui.message("coreapps.patientDashBoard.hideDetails")}</span>
	                <i class="icon-caret-right"></i>
	            </a>
	        </div>
	    </li>
	</ul>

	<span>
		{{ config.printUrl = "/openmrs/module/xreports/fillParameter.form?reportId=&formId=" }}
		<form target="_blank" method="POST" action="{{- config.printUrl }}" >
			<input type="hidden" name="userEnteredParams[patientId]" value="{{- patient.id }}">
			<input type="hidden" name="userEnteredParams[encounterId]" value="{{- encounter.encounterId }}">
			<button type="submit" >
				<i class="printEncounter icon-pencil" data-patient-id="{{- patient.id }}" data-encounter-id="{{- encounter.encounterId }}" data-encounter-type="{{- encounter.encounterType }}" data-edit-url="{{- config.printUrl }}" title="${ ui.message("coreapps.print") }"></i>
			</button>
		</form>

		{{- config }}
		
        {{ if ( (config.editable == null || config.editable) && encounter.canEdit) { }}
            <i class="viewEncounter view-action icon-file-alt" data-mode="view" data-patient-id="{{- patient.id }}" data-encounter-id="{{- encounter.encounterId }}" {{ if (config.viewUrl) { }} data-view-url="{{- config.viewUrl }}" {{ } }} title="${ ui.message("coreapps.view") }"></i>
            <i class="editEncounter edit-action icon-pencil" data-patient-id="{{- patient.id }}" data-encounter-id="{{- encounter.encounterId }}" {{ if (config.editUrl) { }} data-edit-url="{{- config.editUrl }}" {{ } }} title="${ ui.message("coreapps.edit") }"></i>
        {{ } }}
        {{ if ( encounter.canDelete ) { }}
	       <i class="deleteEncounterId delete-action icon-remove" data-visit-id="{{- encounter.visitId }}" data-encounter-id="{{- encounter.encounterId }}" title="${ ui.message("coreapps.delete") }"></i>
        {{  } }}
	</span>

	<div id="encounter-summary{{- encounter.encounterId }}" class="collapse">
	    <div class="encounter-summary-container"></div>
	</div>
</li>
</script>

<script type="text/template" id="defaultEncounterDetailsTemplate">
    {{ _.each(_.filter(diagnoses, function(d) { return d.answer }), function(d) { }}
        <p><small>{{- d.question}}</small><span>{{- d.answer}}</span></p>
    {{ }); }}

    {{ _.each(observations, function(observation) { }}
        {{ if(observation.answer != null) {}}
            <p><small>{{- observation.question}}</small><span>{{- observation.answer}}</span></p>
        {{}}}
    {{ }); }}

    {{ _.each(orders, function(order) { }}
        <p>
            <small>${ ui.message("coreapps.patientDashBoard.orderNumber")}</small><span>{{- order.orderNumber }}</span>
        </p>
        <p>
            <small>${ ui.message("coreapps.patientDashBoard.order")}</small><span>{{- order.concept }}</span>
        </p>
    {{ }); }}
</script>
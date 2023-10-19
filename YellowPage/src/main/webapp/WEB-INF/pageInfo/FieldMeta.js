const info = {
	type: 'basic',
	cudUrl: '/api/entity/fieldMeta/object',
	search: {
		load: true,
		list: [
			{ type: 'text', vModel: 'pk.metaDomain', label: this.$t('label.metaDomain'), placeholder: this.$t('msg.enterData') },
			{ type: 'text', vModel: 'fieldId', label: this.$t('label.id'), placeholder: this.$t('msg.enterId'), regExpType: 'searchId' },
			{ type: 'text', vModel: 'fieldName', label: this.$t('label.name'), placeholder: this.$t('msg.enterName'), regExpType: 'name' },
			{
				type: 'select',
				vModel: 'fieldType',
				label: this.$t('label.type'),
				optionInfo: {
					url: '/api/page/properties',
					params: {
						pk: {
							propertyId: 'List.FieldMeta.FieldType',	
						},
						orderByKey: true
					},					
					optionListName: 'fieldTypeList',
					optionFor: 'option in fieldTypeList',
					optionValue: 'option.pk.propertyKey',
					optionText: 'option.propertyValue',
				},
			},			
			{ type: 'text', vModel: 'fieldDesc', label: this.$t('label.desc'), placeholder: this.$t('msg.enterDesc'), regExpType: 'desc' },
			{
				type: 'dataList',
				vModel: 'pageSize',
				label: this.$t('label.listCount'),
				val: '10',
				optionInfo: {
					optionFor: 'option in [10, 100, 1000]',
					optionValue: 'option',
					optionText: 'option',
				},
			},			
		]
	},
	button: {
		list: [
			{ id: 'add', isUse: true },
			{ id: 'initialize', isUse: true },
			{ id: 'newTab', isUse: true },
		],
	},
	grid: {
		url: '/api/entity/fieldMeta/search',
		totalCntUrl: '/api/entity/fieldMeta/count',
		paging: {
			isUse: true,
			side: 'server',
		},
		options: {
			columns: [
				{
					header: this.$t('label.metaDomain'),
					name: 'pk.metaDomain',
					width: '15%'
				},				
				{
					header: this.$t('label.id'),
					name: 'pk.fieldId',
					width: '20%'
				},				
				{
					header: this.$t('label.name'),
					name: 'fieldName',
					width: '15%'
				},
				{
					header: this.$t('label.type'),
					name: 'fieldType',
					align : "center",
					width: '10%',
		            formatter: function(value) {
		            	const msgObj = {
		            		'B': this.$t("label.fieldMeta.fieldType.byte"),
		            		'S': this.$t("label.fieldMeta.fieldType.short"),
		            		'I': this.$t("label.fieldMeta.fieldType.int"),
		            		'L': this.$t("label.fieldMeta.fieldType.long"),
		            		'F': this.$t("label.fieldMeta.fieldType.float"),
		            		'D': this.$t("label.fieldMeta.fieldType.double"),
		            		'N': this.$t("label.fieldMeta.fieldType.numeric"),
		            		'p': this.$t("label.fieldMeta.fieldType.timeStamp"),
		            		'b': this.$t("label.fieldMeta.fieldType.boolean"),
		            		'v': this.$t("label.fieldMeta.fieldType.individual"),
		            		'A': this.$t("label.fieldMeta.fieldType.raw"),
		            		'P': this.$t("label.fieldMeta.fieldType.packedDecimal"),
		            		'R': this.$t("label.fieldMeta.fieldType.record"),
		            		'T': this.$t("label.fieldMeta.fieldType.string")
		            	};
		            	
		            	return msgObj[value.row.fieldType];
		            }
				},
				{
					header: this.$t('label.length'),
					name: 'fieldLength',
					width: '10%',
					align: 'right'
				},
				{
					header: 'Scale',
					name: 'fieldScale',
					width: '10%',
					align: 'right'
				},				
				{
					header: this.$t('label.desc'),
					name: 'fieldDesc',
					width: '20%'
				},				
			],
		},
	},
	detail: {
		pk: ['pk.metaDomain', 'pk.fieldId'],
		button: {
			list: [
				{ id: 'insert', isUse: true },
				{ id: 'update', isUse: true },
				{ id: 'delete', isUse: true },
				{ id: 'reference', isUse: true, className: 'com.inzent.yellowpage.model.FieldMeta' }
			],
		},
		tabList: [
			{
				type: 'basic',
				label: this.$t('label.basicInfo'),
				content: [
					[
						[
							{
								type: 'text',
								vModel: 'pk.metaDomain',
								label: this.$t('label.metaDomain'),
								isPK: true,
								regExpType: 'id'
							},		
							{
								type: 'text',
								vModel: 'pk.fieldId',
								label: this.$t('label.id'),
								isPK: true,
								regExpType: 'id'
							},
							{
								type: 'text',
								vModel: 'fieldName',
								label: this.$t('label.name'),
								isRequired: true,
								regExpType: 'name',
							},
							{
								type: 'text',
								vModel: 'fieldIndex',
								label: 'Index',
							},							

						],
						[
							{
								type: 'text',
								vModel: 'originalType',
								label: 'Original ' + this.$t('label.type'),
							},							
							{
								type: 'text',
								vModel: 'originalLength',
								label: 'Original ' + this.$t('label.length'), 
								regExpType: 'num'
							},
							{
								type: 'text',
								vModel: 'originalScale',
								label: 'Original Scale',
								regExpType: 'num'
							},							
						],						
						[
							{
								type: 'select',
								vModel: 'fieldType',
								label: this.$t('label.type'),
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.FieldMeta.FieldType',	
										},
										orderByKey: true
									},					
									optionListName: 'fieldTypeList',
									optionFor: 'option in fieldTypeList',
									optionValue: 'option.pk.propertyKey',
									optionText: 'option.propertyValue',
								},
								isRequired: true,
							},
							{
								type: 'text',
								vModel: 'fieldLength',
								label: this.$t('label.length'),
								regExpType: 'num'
							},							
							{
								type: 'text',
								vModel: 'fieldScale',
								label: 'Scale',
								regExpType: 'num'
							},		
						],
						[
							{
								type: 'select',
								vModel: 'fieldRequireYn',
								label: 'Require',
								val: 'N',
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.Yn',	
										},
										orderByKey: true,
									},
									optionListName: 'ynList',
									optionFor: 'option in ynList',
									optionValue: 'option.pk.propertyKey',
									optionText: 'option.propertyValue',
								},
							},							
							{
								type: 'select',
								vModel: 'fieldHiddenYn',
								label: 'Hidden',
								val: 'N',
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.Yn',	
										},
										orderByKey: true,
									},
									optionListName: 'ynList',
									optionFor: 'option in ynList',
									optionValue: 'option.pk.propertyKey',
									optionText: 'option.propertyValue',
								},
							},
							{
								type: 'text',
								vModel: 'codecId',
								label: 'Codec Id',
								regExpType: 'id'
							},
							{
								type: 'select',
								vModel: 'useYn',
								label: this.$t('label.useyn'),
								val: 'Y',
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.Yn',	
										},
										orderByKey: true,
									},
									optionListName: 'ynList',
									optionFor: 'option in ynList',
									optionValue: 'option.pk.propertyKey',
									optionText: 'option.propertyValue',
								},								
							}
						]
					],
					[
						[
							{
								type: 'textarea',
								vModel: 'fieldDesc',
								label: this.$t('label.desc'),
								height: '110px',
								regExpType: 'desc',
							}
						]
					]
				]
			},
			{
				id: 'useInfo',
				type: 'basic',
				label: this.$t('label.useInfo'),
				content: [
					[
						[
							{
								type: 'text',
								vModel: 'updateUserId',
								label: this.$t('label.writer'),
								readonly: true
							},
							{
								type: 'text',
								vModel: 'updateTimestamp',
								label: this.$t('label.created.date'),
								readonly: true,
								formatter: function(value) {
									return value ? value.substring(0, 19) : value;
								}
							},
							{
								type: 'text',
								vModel: 'updateVersion',
								label: 'Version',
								readonly: true,
								val: '0'
							}							
						]
					]
				]
			}
		]
	}
};
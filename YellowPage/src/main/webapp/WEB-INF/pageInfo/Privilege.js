const info = {
	type: 'basic',
	cudUrl: '/api/entity/privilege/object',
	search: {
		load: true,
		list: [			
			{ type: 'text', 	vModel: 'privilegeId',		label: this.$t('label.id'),	placeholder: this.$t('msg.enterId'),  regExpType: 'searchId' },
			{
				type: 'select',
				vModel: 'privilegeType',
				label: this.$t('label.type'),
				optionInfo: {
					url: '/api/page/properties',
					params: {
						pk: {
							propertyId: 'List.Privilege.Type',	
						},
						orderByKey: true
					},
					optionListName: 'privilegeTypeList',
					optionFor: 'option in privilegeTypeList',
					optionValue: 'option.pk.propertyKey',
					optionText: 'option.propertyValue',
				},
			},
			{ type: 'text', 	vModel: 'privilegeDesc',   	label: this.$t('label.desc'), placeholder: this.$t('msg.enterDesc'), regExpType: 'desc' },
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
		],
	},
	button: {
		list: [
			{ id: 'add', isUse: true },
			{ id: 'initialize', isUse: true },
			{ id: 'newTab', isUse: true },
		],
	},
	grid: {
		url: '/api/entity/privilege/search',
		totalCntUrl: '/api/entity/privilege/count',
		paging: {
			isUse: true,
			side: 'server',
		},
		options: {
			columns: [
				{
					header: this.$t('label.id'),
					name: 'privilegeId',
					width: '35%',
				},				
            	{
					header: this.$t('label.type'),
					name: 'privilegeType',
					 width: '30%',
					 formatter : function(value) {
						 return (value.row.privilegeType == "S")? this.$t('label.privilege.type.system') : this.$t('label.privilege.type.business');
					 }
				},
				{
              		header : this.$t('label.desc'),
              		name : 'privilegeDesc',
                    width: '35%',
            	},				
			],
		},
	},

	detail: {
		pk: ['privilegeId'],
		button: {
			list: [
				{ id: 'insert', isUse: true },
				{ id: 'update', isUse: true },
				{ id: 'delete', isUse: true },
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
								vModel: 'privilegeId',
								label: this.$t('label.id'),
								isPK: true,
								regExpType: 'id',
							},				
						],
						[
							{
								type: 'select',
								vModel: 'privilegeType',
								label: this.$t('label.type'),
								isRequired: true,
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.Privilege.Type',	
										},
										orderByKey: true
									},
									optionListName: 'privilegeTypeList',
									optionFor: 'option in privilegeTypeList',
									optionValue: 'option.pk.propertyKey',
									optionText: 'option.propertyValue',
								},
							},			
						],	
					],
					[
						[
							{
								type: 'textarea',
								vModel: 'privilegeDesc',
								label: this.$t('label.desc'),
							},							
						]
					]
				],
			},
		],
	},
};
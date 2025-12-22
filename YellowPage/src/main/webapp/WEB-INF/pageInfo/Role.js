const info = {
	type: 'basic',
	cudUrl: '/api/entity/role/object',
	search: {
		load: true,
		list: [			
			{ type: 'text', 	vModel: 'roleId',		label: this.$t('label.id'),			placeholder: this.$t('msg.enterId'),		 	regExpType: 'searchId' },
			{ type: 'text', 	vModel: 'roleDesc',   	label: this.$t('label.desc'),	 	placeholder: this.$t('msg.enterDesc'), 			regExpType: 'desc' },
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
		url: '/api/entity/role/search',
		totalCntUrl: '/api/entity/role/count',
		paging: {
			isUse: true,
			side: 'server',
		},
		options: {
			columns: [
				{
					header: this.$t('label.id'),
					name: 'roleId',
					width: '45%',
				},				
				{
              		header : this.$t('label.desc'),
              		name : 'roleDesc',
                    width: '55%',
            	},
			],
		},
	},
	detail: {
		pk: ['roleId'],
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
								vModel: 'roleId',
								label: this.$t('label.id'),
								isPK: true,
								regExpType: 'id',
							},
						],
						[
							
						],
					],
					[
						[
							{
								type: 'textarea',
								vModel: 'roleDesc',
								label: this.$t('label.desc'),
								regExpType: 'desc',
							},
						],
						
					]
				],
			},
			{
				type: 'property',
				label: this.$t('label.roleInfo'),
				dataKey: 'rolePrivileges',
				addRowInfo: {
					type: 'modal',
					modalInfo: {
						title: this.$t('label.privilege'),
						search: {
							list: [
								{ type: 'text', 	vModel: 'privilegeId',		label: this.$t('label.id'),			placeholder: this.$t('msg.enterId'), 			regExpType: 'id' },
								{ type: 'text', 	vModel: 'privilegeDesc',   	label: this.$t('label.desc'), 		placeholder: this.$t('msg.enterDesc'), 			regExpType: 'desc' },
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
											orderByKey: true,
										},
										optionListName: 'privilegeType',
										optionFor: 'option in privilegeType',
										optionValue: 'option.pk.propertyKey',
										optionText: 'option.propertyValue',
									},
								},
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
							list: [{ id: 'initialize', isUse: true }],
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
									},
									{
										header: this.$t('label.type'),
										name: 'privilegeType',
										formatter : function(value) {
											return (value.row.privilegeType == "S")? this.$t('label.privilege.type.system') : this.$t('label.privilege.type.business');
							            }
									},
									{
										header: this.$t('label.desc'),
										name: 'privilegeDesc',
									},
								],
							},
						},
						rowClickedCallback: function (rowInfo, propertyList) {
							return {
								duplicate : 0 === propertyList.length ? false : propertyList.some(function(property) { return property['pk.privilegeId'] === rowInfo.privilegeId }),
								propertyInfo : {'pk.privilegeId': rowInfo.privilegeId}
							};
						},
					},
				},
				content: [
					{
						type: 'text',
						vModel: 'pk.privilegeId',
						label: this.$t('label.privilege') + ' ' + this.$t('label.id'),
						readonly: true,
					},
				],
			},
		],
	},
};
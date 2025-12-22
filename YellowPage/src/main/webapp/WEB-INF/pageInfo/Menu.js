const info = {
	type: 'basic',
	cudUrl: '/api/entity/menu/object',
	search: {
		load: true,
		list: [
			{ type: 'text', vModel: 'menuId', 		label: this.$t('label.id'), 				placeholder: this.$t('msg.enterId'), regExpType: 'searchId' },
			{ type: 'text', vModel: 'menuName', 	label: this.$t('label.name'), 				placeholder: this.$t('msg.enterName') },
			{ type: 'text', vModel: 'menuUrl', 		label: this.$t('label.menu.webUrl'),		placeholder: this.$t('msg.enterData'), regExpType: 'url'},			
			{
				type: 'modal',
				vModel: 'menuPrivilegeId',
				label: this.$t('label.privilege') + ' ' + this.$t('label.id'),
				placeholder: this.$t('msg.enterId'),
				modalInfo: {
					title: this.$t('label.privilege'),
					search: {
						list: [
							{ type: 'text', 	vModel: 'privilegeId',		label: this.$t('label.id'),				placeholder: this.$t('msg.enterId'), 			regExpType: 'searchId' },
							{ type: 'text', 	vModel: 'privilegeDesc',   	label: this.$t('label.desc'), 			placeholder: this.$t('msg.enterDesc'), 			regExpType: 'desc' },
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
					rowClickedCallback: function (rowInfo) {
						return rowInfo.privilegeId;
					},
				},
			},
			{ type: 'text', vModel: 'parentMenuId', label: this.$t('label.menu.parentMenu'), 	placeholder: this.$t('msg.enterData'), regExpType: 'num' },
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
		url: '/api/entity/menu/search',
		totalCntUrl: '/api/entity/menu/count',
		paging: {
			isUse: true,
			side: 'server',
		},
		options: {
			columns: [
				{
					header: this.$t('label.id'),
					name: 'menuId',
					width: '20%'
				},
				{
					header: this.$t('label.name'),
					name: 'menuName',
					width: '20%'
				},
				{
					header: this.$t('label.menu.webUrl'),
					name: 'menuUrl',
					width: '25%'
				},
				{
					header: this.$t('label.privilege') + ' ' + this.$t('label.id'),
					name: 'menuPrivilegeId',
					width: '15%'
				},
				{
					header: this.$t('label.menu.parentMenu'),
					name: 'parentMenuId',
					width: '20%'
				},
			],
		},
	},

	detail: {
		pk: ['menuId'],
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
								vModel: 'menuId',
								label: this.$t('label.id'),
								isPK: true,
								regExpType: 'id',
							},
							{
								type: 'text',
								vModel: 'menuName',
								label: this.$t('label.name'),
								isRequired: true,
							},
							{
								type: 'text',
								vModel: 'menuIcon',
								label: this.$t('label.menu.icon'),
							},
							{
								type: 'text',
								vModel: 'menuUrl',
								label: this.$t('label.menu.webUrl'),
								regExpType: 'url'
							},							
						],
						[
							{
								type: 'select',
								vModel: 'openWindow',
								label: this.$t('label.menu.openWindow'),
								val: 'N',
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.Yn',	
										},
										orderByKey: true
									},					
									optionListName: 'openWindowList',
									optionFor: 'option in openWindowList',
									optionValue: 'option.pk.propertyKey',
									optionText: 'option.propertyValue',
								},
								isRequired: true,
							},
							{
								type: 'modal',
								vModel: 'menuPrivilegeId',
								label: this.$t('label.privilege'),
								modalInfo: {
									title: this.$t('label.privilege'),
									search: {
										list: [
											{ type: 'text', 	vModel: 'privilegeId',		label: this.$t('label.id'),			placeholder: this.$t('msg.enterId'), 		regExpType: 'id' },
											{ type: 'text', 	vModel: 'privilegeDesc',   	label: this.$t('label.desc'), 		placeholder: this.$t('msg.enterDesc'),		regExpType: 'desc' },
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
									rowClickedCallback: function (rowInfo) {
										return rowInfo.privilegeId;
									},
								},
							},
							{
								type: 'text',
								vModel: 'parentMenuId',
								label: this.$t('label.menu.parentMenu'),
								regExpType: 'id'
							},
						],
					],
				],
			},
		],
	},
};
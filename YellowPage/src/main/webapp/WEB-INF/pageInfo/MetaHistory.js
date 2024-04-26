const info = {
	type: 'basic',
	cudUrl: '/api/entity/metaHistory/object',
	search: {
		list: [			
			{ type: 'singleDaterange', 	vModel: 'modifyDateTimeFrom',		label: this.$t('label.from'), 	dateRangeType : 'from'},
			{ type: 'singleDaterange', 	vModel: 'modifyDateTimeTo',			label: this.$t('label.to'), 	dateRangeType : 'to'},
			{ type: 'text', 			vModel: 'entityName',				label: this.$t('label.metaHistory.entityName'),			placeholder: this.$t('msg.enterName'), 	regExpType: 'name' },
			{ type: 'text', 			vModel: 'entityId',					label: this.$t('label.metaHistory.entityId'),			placeholder: this.$t('msg.enterId'), 	regExpType: 'searchId' },
			{
				type: 'select',
				vModel: 'modifyType',
				label: this.$t('label.metaHistory.modifyType'),
				optionInfo: {
					url: '/api/page/properties',
					params: {
						pk: {
							propertyId: 'List.MetaHistory.Type',	
						},
						orderByKey: true,
					},
					optionListName: 'metaHistoryTypes',
					optionFor: 'option in metaHistoryTypes',
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
		list: [
			{ id: 'initialize', isUse: true },
			{ id: 'newTab', isUse: true },
		],
	},
	grid: {
		url: '/api/entity/metaHistory/search',
		totalCntUrl: '/api/entity/metaHistory/count',
		paging: {
			isUse: true,
			side: 'server',
		},
		options: {
			columns: [
            	{
              		header : this.$t('label.update.timestamp'),
              		name : 'pk.modifyDateTime',
                    width: '20%',
              		align : 'center',
              		formatter: function(obj) {
              			return obj.value.substring(0, 19);
              		}
            	},				
				{
              		header : this.$t('label.metaHistory.entityName'),
              		name : 'entityName',
                    width: '20%',
            	},
				{
					header: this.$t('label.metaHistory.entityId'),
					name: 'entityId',
					width: '20%',
				},	
				{
					header: 'Entity Version',
					name: 'entityVersion',
					width: '10%',
					align: 'right'
				},
				{
					header: this.$t('label.metaHistory.modifyType'),
					name: 'modifyType',
					width: '20%',
					align: 'center',
					formatter: function(value) {
						var modifyType = value.row.modifyType;
						return 'D' == modifyType? this.$t('label.delete') : 'I' == modifyType? this.$t('label.insert') : 'R' == modifyType? this.$t('label.restore') : 'U' == modifyType? this.$t('label.update') : '';
					}
				},  
				{
					header: this.$t('label.update') + ' ' + this.$t('label.user.id'),
					name: 'updateUserId',
					width: '10%'
				}				
			],
		},
	},

	detail: {
		pk: ['pk.modifyDateTime', 'pk.modifyId'],
		button: {
			list: [
				{ 
					id: 'restore', 
					isUse: function(object) { 
						return (object.entityName !== 'com.inzent.imanager.repository.meta.User' && object.beforeDataString)? true : false; 
					} 
				},
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
								vModel: 'pk.modifyDateTime',
								label: this.$t('label.update.timestamp'),
								isPK: true,
								formatter: function(value) {
									return value ? value.substring(0, 19) : value;
								}
							},
							{
								type: 'text',
								vModel: 'entityName',
								label: this.$t('label.metaHistory.entityName'),
							},
							{
								type: 'text',
								vModel: 'entityId',
								label: this.$t('label.metaHistory.entityId'),
							},							
							{
                                type: "text",
                                vModel: "entityVersion",
                                label: 'Entity Version',
                            }							
						],
						[
							{
								type: 'select',
								vModel: 'modifyType',
								label: this.$t('label.metaHistory.modifyType'),
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.MetaHistory.Type',	
										},
										orderByKey: true,
									},
									optionListName: 'metaHistoryTypes',
									optionFor: 'option in metaHistoryTypes',
									optionValue: 'option.pk.propertyKey',
									optionText: 'option.propertyValue',
								},
							},	
							{
								type: 'text',
								vModel: 'updateUserId',
								label: this.$t('label.update') + ' ' + this.$t('label.user.id'),
							},
							{
								type: 'text',
								vModel: 'updateRemoteAddress',
								label: this.$t('label.metaHistory.remote.address'),
							},							
							{
								type: 'text',
								vModel: 'pk.modifyId',
								label: this.$t('label.update') + ' ' + this.$t('label.id'),
								isPK: true,
							},
						],
					],
				],
			},
			{
				type: 'bundle',
				label: 'Modified Contents',
                url: '/metaHistory/Modified',
			},
		],
	},
};
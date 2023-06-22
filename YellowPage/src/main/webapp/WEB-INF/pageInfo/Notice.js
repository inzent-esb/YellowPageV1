const info = {
	type: 'basic',
	cudUrl: '/api/entity/notice/object',
	privilegeType: 'Notice',
	search: {
		load: true,
		list: [			
			{ 
				type: 'text', 	
				vModel: 'noticeTitle',		
				label: this.$t('label.title'),		
				placeholder: this.$t('msg.enterTitle') 
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
			{ id: 'add', isUse: true },
			{ id: 'initialize', isUse: true },
			{ id: 'newTab', isUse: true },
		],
	},
	grid: {
		url: '/api/entity/notice/search',
		totalCntUrl: '/api/entity/notice/count',
		paging: {
			isUse: true,
			side: 'server',
		},
		options: {
			columns: [
				{
					header: this.$t('label.title'),
					name: 'noticeTitle',
					width: '5%',
				},				
				{
              		header : this.$t('label.writer'),
              		name : 'userId',
                    width: '30%',
            	},
            	{
                    header : this.$t('label.created.date'),
              		name : 'pk.createTimestamp',
                    width: '30%',
              		align : 'center',
              		formatter: function(obj) {
              			return obj.value.substring(0, 19);
              		},
            	},
			],
		},
	},
	detail: {
		pk: ['pk.createTimestamp', 'pk.noticeId'],
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
								vModel: 'noticeTitle',
								label: this.$t('label.title'),
								isRequired: true,
							},
						],						
					],
					[
						[
							{
								type: 'textarea',
								vModel: 'noticeContent',
                                label: this.$t('label.content'),
								height: '200px',
								isRequired: true,
							},
						],						
					],
				],
			},
		],
	},
};
var constants = {
	 regExpList: {
		id: { maxLength: 70, regExp: '[^A-Za-z0-9_.-]'},
		searchId: { maxLength: 70, regExp: '[^A-Za-z0-9_.#%-]'},
		name: { maxLength: 70, regExp: '' },
		value: { maxLength: 90, regExp: '' },
		desc: { maxLength: 500, regExp: '' },
		num: { maxLength: 30, regExp: '[^0-9]' },
		url: { maxLength: 100, regExp: '' },
		ip: { maxLength: 30, regExp: '[^0-9.]' },
		className: { maxLength: 200, regExp: '[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]' },
		cron: { maxLength: 30, regExp: '[^A-Za-z0-9*,#-? ]'},
		password: { maxLength: 30, regExp: '[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]'},
		pageSize: { maxLength: 4, regExp: '[^0-9]' },
		default: { maxLength: 100, regExp: '' }
	},
	logInTime: 300000,
	//escape: 27, space: 32
	modalCloseKeyCode: [27, 32],
	isUseTheme: true,
	
	grid : {
        gridOptionFunc: function(gridOptions, isModal) {
        	//var url = gridOptions.url? gridOptions.url : gridOptions.searchUrl;
			
			/*
			if ('/api/entity/notice/search' === url) {
				gridOptions.options.columns[0].sortable = true;
			}
			*/
			
			return gridOptions;
		},
		pageOptionFunc: function(searchUrl) {
			var limit = 100;
			var ascending = true;
			
			if ('/api/entity/metaHistory/search' === searchUrl || '/api/entity/notice/search' === searchUrl || '/api/entity/publishLog/search' === searchUrl) {
				ascending = false;
			}

			return {
				limit: limit,
				ascending: ascending
			}
		},
		maxListCount: {
			103010 : 1000,
		}
	},
	
	detail: {
		105000: {
			selectedInfoTitleKey: ['pk.publishDateTime', 'pk.publishId']
		},
	},
	
	// 명세서 기능
	isSpecification: true,
	
	isDetailExpand: true,
	
	ifResMapSourceSvcResOnly: true
};
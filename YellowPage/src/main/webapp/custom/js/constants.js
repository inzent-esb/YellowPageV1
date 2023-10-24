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
	
	motionDetectTime: 1000,
	autoLogoutTime: 1200000,
	
	//escape: 27, space: 32
	modalCloseKeyCode: [27, 32],
	isUseTheme: true,
	
	search: {
		searchListFunc: function(menuId, searchList) {
			/*
			if ('301000' === menuId) {
				searchList[0].label = 'TEST';
			}*/
						
			return searchList;
		}
	},
	
	grid : {
        gridOptionFunc: function(menuId, searchUrl, gridOptions) {
			/*
			if ('301000' === url) {
				gridOptions.options.columns[0].sortable = true;
			}
			*/
			
			return gridOptions;
		},
		pageOptionFunc: function(menuId, searchUrl) {
			var limit = 100;
			var ascending = true;
			
			// 수정내역, 공지사항, 배포 로그
			if ('302000' === menuId || '301000' === menuId || '105000' === menuId) {
				ascending = false;
            } else if (('101000' === menuId || '102000' === menuId || '103000' === menuId || '206000' === menuId) && '/api/entity/metaHistory/search' === searchUrl) {
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
		tabListFunc: function(menuId, tabList) {
			/*
			if ('301000' === menuId) {
				var basicInfo = tabList[0].content;
				
				basicInfo[0][0][0].label = window.$t('label.notice');
			}*/
			
			return tabList;
		},
		selectedInfoTitleKey: {
			105000: ['pk.publishDateTime', 'pk.publishId']
		},
	},
	
	// 명세서 기능
	isSpecification: true,
	
	isDetailExpand: false,
	
	ifResMapSourceSvcResOnly: false
};
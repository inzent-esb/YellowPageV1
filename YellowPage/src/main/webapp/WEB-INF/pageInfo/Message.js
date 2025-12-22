const info = {
	type: "basic",
	cudUrl: '/api/entity/message/object',
	search: {
		load: true,
		list: [
			{
				type: "select",
				vModel: "messageCategory",
				label: this.$t("label.message.category"),
				optionInfo: {
					url: '/api/page/properties',
					params: {
						pk: {
							propertyId: 'List.Message.MessageCategory'
						},
						orderByKey: true
					},
					optionListName: "messageCategories",
					optionFor: "option in messageCategories",
					optionValue: "option.pk.propertyKey",
					optionText: "option.propertyValue"
				}
			},
			{
				type: "dataList",
				vModel: "pk.messageLocale",
				label: this.$t("label.message.locale"),
				placeholder: this.$t("msg.enterData"),
				optionInfo: {
					url: "/api/entity/message/group/search",
					optionListName: "messageLocales",
					optionFor: "option in messageLocales",
					optionValue: "option",
					optionText: "option"
				}
			},
			{
				type: "text",
				vModel: "pk.messageCode",
				label: this.$t("label.message.code"),
				placeholder: this.$t("msg.enterCode")
			},
			{
				type: "text",
				vModel: "messageFormat",
				label: this.$t("label.message.format"),
				placeholder: this.$t("msg.enterData")
			},
			{
				type: "dataList",
				vModel: "pageSize",
				label: this.$t("label.listCount"),
				val: "10",
				optionInfo: {
					optionFor: "option in [10, 100, 1000]",
					optionValue: "option",
					optionText: "option"
				}
			}
		]
	},
	button: {
		list: [
			{ id: "add", isUse: true },
			{ id: "initialize", isUse: true },
			{ id: "newTab", isUse: true }
		]
	},
	grid: {
		url: '/api/entity/message/search',
		totalCntUrl: '/api/entity/message/count',
		paging: {
			isUse: true,
			side: "server"
		},
		options: {
			columns: [
				{
					name: "messageCategory",
					header: this.$t("label.message.category"),
					align: "center",
					width: "25%"
				},
				{
					name: "pk.messageLocale",
					header: this.$t("label.message.locale"),
					align: "center",
					width: "15%"
				},
				{
					name: "pk.messageCode",
					header: this.$t("label.message.code"),
					align: "left",
					width: "30%"
				},
				{
					name: "messageFormat",
					header: this.$t("label.message.format"),
					align: "left",
					width: "30%"
				}
			]
		}
	},

	detail: {
		pk: ["pk.messageCode", "pk.messageLocale"],
		button: {
			list: [
				{ id: "insert", isUse: true },
				{ id: "update", isUse: true },
				{ id: "delete", isUse: true }
			]
		},
		tabList: [
			{
				type: "basic",
				label: this.$t("label.basicInfo"),
				content: [
					[
						[
							{
								type: "text",
								vModel: "pk.messageCode",
								label: this.$t("label.message.code"),
								isPK: true
							},
							{
								type: "dataList",
								vModel: "pk.messageLocale",
								isPK: true,
								label: this.$t("label.message.locale"),
								optionInfo: {
									url: "/api/entity/message/group/search",
									optionListName: "messageLocales",
									optionFor: "option in messageLocales",
									optionValue: "option",
									optionText: "option"
								}
							}
						],
						[
							{
								type: "select",
								vModel: "messageCategory",
								label: this.$t("label.message.category"),
								isRequired: true,
								optionInfo: {
									url: '/api/page/properties',
									params: {
										pk: {
											propertyId: 'List.Message.MessageCategory'
										},
										orderByKey: true
									},
									optionListName: "messageCategory",
									optionFor: "option in messageCategory",
									optionValue: "option.pk.propertyKey",
									optionText: "option.propertyValue"
								}
							},
							{
								type: "text",
								vModel: "messageFormat",
								label: this.$t("label.message.format")
							}
						]
					]
				]
			}
		]
	}
};

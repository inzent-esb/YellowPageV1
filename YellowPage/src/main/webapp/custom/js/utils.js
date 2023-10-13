function escapeHtml(text) {
	return $('<span />').text(text).html();
}

function unescapeHtml(text) {
	return $('<span />').html(text).text();
}

function encryptPassword(password) {
	if (!password) return null;

	var key = (function () {
		var characters = 'ABCDEF0123456789';

		var result = '';

		for (var i = 0; i < 32; i++) {
			result += characters.charAt(Math.floor(mathRandom() * characters.length));
		}

		return result;
	})();

	var encrypt = CryptoJS.AES.encrypt(password, CryptoJS.enc.Hex.parse(key), { iv: CryptoJS.enc.Hex.parse(key) });

	return '{jst}' + btoa(key + encrypt.toString());
}

function mathRandom() {
	var cryptoObj = window.crypto || window.msCrypto;

	var arr = new Uint32Array(1);

	cryptoObj.getRandomValues(arr);

	return arr[0] / Math.pow(2, 32); //4294967296
}

function numberWithComma(number) {
	return 0 === number? '0' : number ? number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') : '';
}

function initSelectPicker(element, selectedValue) {
	if ('undefined' != typeof selectedValue) $(element).selectpicker('val', selectedValue);
	else $(element).selectpicker();

	$(element).on({
		'show.bs.select': function (e) {
			var label = $(e.target).parents('.form-control-label');
			label.length && label.addClass('active');
		},
		'hide.bs.select': function (e) {
			var label = $(e.target).parents('.form-control-label');
			label.length && label.removeClass('active');
		}
	});
}

function getRegExpInfo(type) {
	return constants.regExpList[type];
}

function setLengthCnt(info) {
   var keyList = info.key.split('.').slice(1);
   
   var regExp = info.regExp;
   var object = this.object? this.object : this;
   var objectLetter = this.letter;
   
   keyList.forEach(function(key, index) {
      key = key.toString();
      
      if(index !== keyList.length - 1) {
         object = object[key];
         objectLetter = objectLetter[key];
      } else {      
         object[key] = object[key]? object[key].replace(new RegExp(regExp, 'g'), '') : '';
         objectLetter[key] = object[key]? object[key].length : 0;
      }
   });
}

function getUUID() {
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
		var r = (mathRandom() * 16) | 0,
			v = c == 'x' ? r : (r & 0x3) | 0x8;
		return v.toString(16);
	});
}

function removeStorage() {
	clearStorage(localStorage, function(key) {
		return 'ckSaveUserId' === key || 'saveUserId' === key;
	});
	
	clearStorage(sessionStorage);
}

function clearStorage(storage, continueFunc) {
	for (var key in storage) {
		if (continueFunc && continueFunc(key)) continue;
		storage.removeItem(key);
	}
}

function getCurrentMenuId() {
	var selectedMenuPathIdList = JSON.parse(sessionStorage.getItem('selectedMenuPathIdList'));
	var selectMenu = selectedMenuPathIdList[selectedMenuPathIdList.length - 1].split('_')[0];

	return selectMenu;
}

function getFileSize(fileSize){
	var rtn = 0;
	  
	if(fileSize > 0) {
		rtn = Math.round( fileSize / 1024 );
		if(rtn <= 0) rtn = 1;
	}
	  
	return rtn;
}

function changeDateFormat(date, format) {	
	if (!date) return date;
	
	return moment(new Date(date.split('.')[0].replace('-', '/'))).format(format ? format : 'YYYY-MM-DD HH:mm:ss');
}

function getNumFromStr(str) {
	return Number(str.replace(/[^0-9]/g, ''));
}

function parseFlattenObj(obj, pRoots, pSep) {
	var roots = pRoots? pRoots : []; 
	var sep = pSep? pSep : '.';
	
	return Object.keys(obj).reduce(
		function (memo, prop) {
			return Object.assign(
				{},
				memo,
				Object.prototype.toString.call(obj[prop]) === '[object Object]'
					? parseFlattenObj(obj[prop], roots.concat([prop]))
					:
					(function() {
						var source = {};
						source[roots.concat([prop]).join(sep)] = obj[prop];
						return source;
					})()
			)
		},
		{}
	);
}

function endsWith(str, searchString, position) {
	var subjectString = str.toString();

	if (typeof position !== 'number' || !isFinite(position) || Math.floor(position) !== position || position > subjectString.length) {
		position = subjectString.length;
	}
    
	position -= searchString.length;
    
	var lastIndex = subjectString.indexOf(searchString, position);
    
	return lastIndex !== -1 && lastIndex === position;	
}

function makeGridOptions(gridOptions, formatterData) {
	gridOptions = $.extend(true, {}, gridOptions);

	var options = {
		width: null,
		columns: [],
		header: {
			height: 32,
			align: 'center'
		},
		columnOptions: {
			resizable: true,
			minWidth: 1
		},
		contextMenu: function() {
			return [];
		},
		scrollX: true,
		data: [],
		usageStatistics: false
	};
	
	options = $.extend(true, options, gridOptions);
	
	var columnsExcludeHidden = options.columns.filter(function(column) { return !column.hidden });
	var widthConfigType = null;
	
	if (0 < columnsExcludeHidden.length) {
		if (columnsExcludeHidden.length === columnsExcludeHidden.filter(function(column) { return column.width && String(column.width).endsWith('%') }).length) {
			widthConfigType = 'percent';
		} else if (columnsExcludeHidden.length === columnsExcludeHidden.filter(function(column) { return column.width && 'number' === typeof column.width }).length) {
			widthConfigType = 'pixel';
		}
		
		if (null === widthConfigType) {
			widthConfigType = 'percent';
			
			columnsExcludeHidden.forEach(function(column) {
				column.width = (100 / columnsExcludeHidden.length) + '%';
			});
		}
	}

	columnsExcludeHidden.forEach(function(column) {
		if (column.formatter) {
			var formatterFunc = column.formatter;

			column.formatter = function(info) {
				if (formatterData) info.formatterData = formatterData;

				return formatterFunc(info);
			};
		} else {
			column.escapeHTML = true;
		}

		if (column.width && -1 < String(column.width).indexOf('%')) {
			if (!column.copyOptions) column.copyOptions = {};
			
			column.copyOptions.widthRatio = column.width.replace('%', '');

			delete column.width;
		}
	});

	var onGridMounted = gridOptions.onGridMounted;
	delete options.onGridMounted;
	delete gridOptions.onGridMounted;

	options.onGridMounted = function(evt) {
		if (!evt.instance) return;

		if (!evt.instance.el) return;

		for (var attributeKey in options) {
			evt.instance.el.removeAttribute(attributeKey);
		}

		evt.instance.on('mouseover', function(mouseEvt) {
			if ('cell' !== mouseEvt.targetType) return;

			var element = mouseEvt.instance.getElement(mouseEvt.rowKey, mouseEvt.columnName);
			var value = unescapeHtml(mouseEvt.instance.getFormattedValue(mouseEvt.rowKey, mouseEvt.columnName));

			element.setAttribute('title', value);
		});
		
        var agent = navigator.userAgent.toLowerCase();
        
        if (!(navigator.appName == 'Netscape' && -1 != agent.indexOf('trident')) || -1 != agent.indexOf('msie')) {
            evt.instance.on('dblclick', function(dblClickEvt) {
                var span = document.createElement('span');
                span.style.fontSize = '13px';
                span.style.padding = '4px 5px';
                span.style.opacity = '0';
                span.style.position = 'absolute';
                document.body.appendChild(span);
                
                var maxWidth = 0;

                dblClickEvt.instance.el.querySelectorAll('.tui-grid-cell').forEach(function(cell) {
                    if (cell.classList.contains('tui-grid-cell-header')) return;

                    if (cell.dataset.columnName !== dblClickEvt.nativeEvent.target.dataset.columnName) return;
                    
                    span.innerText = cell.innerText;

                    maxWidth = Math.max(maxWidth, span.offsetWidth);
                });
                
                document.body.removeChild(span);

                var columnWidths = dblClickEvt.instance.getColumns().map(function(column) { return column.baseWidth });
                columnWidths[dblClickEvt.nativeEvent.target.dataset.columnIndex] = maxWidth + 20;

                evt.instance.resetColumnWidths(columnWidths);

                evt.instance.refreshLayout();
            });            
        }        
        
		if ('percent' == widthConfigType) {
			var width = null;
			
			var containerEl = evt.instance.el.querySelector('.tui-grid-container');

			var resizeObserver = function() {
				if (!document.body.contains(evt.instance.el)) {
					cancelAnimationFrame(rafId);
					return;
				}

				if (containerEl.style.width && width !== containerEl.style.width) {
					width = containerEl.style.width;

					var columns = $.extend(true, [], evt.instance.getColumns());

					columns.forEach(function(columnInfo) {
						if (columnInfo.hidden) return;

						if (!columnInfo.copyOptions) return;

						if (!columnInfo.copyOptions.widthRatio) return;
						
						columnInfo.width = (Number(containerEl.style.width.replace('px', '')) - 17 - evt.instance.el.querySelector('.tui-grid-lside-area').offsetWidth) * (columnInfo.copyOptions.widthRatio / 100);
					});

					evt.instance.setColumns(columns);
				}

				rafId = requestAnimationFrame(resizeObserver);
			};

			var rafId = requestAnimationFrame(resizeObserver);
		}
		
		if (onGridMounted) onGridMounted(evt);
	};
	
	var onGridUpdated = gridOptions.onGridUpdated;
	delete options.onGridUpdated;
	delete gridOptions.onGridUpdated;

	options.onGridUpdated = function(evt) {
		for (var attributeKey in options) {
			evt.instance.el.removeAttribute(attributeKey);
		}
		
		evt.instance.refreshLayout();
		
		if (onGridUpdated) onGridUpdated(evt);
	};

	return options;
}

function parseHierarchyObj(obj) {
	var result = {};
	
	for (var key in obj) {
		
		if (obj.hasOwnProperty(key)) {
			var parts = key.split('.');
			var temp = result;

			for (var i = 0; i < parts.length - 1; i++) {
				if (!temp[parts[i]]) {
					temp[parts[i]] = {};
				}
				temp = temp[parts[i]];
			}

			var lastPart = parts[parts.length - 1];

			if (typeof obj[key] === 'object' && obj[key] !== null && !Array.isArray(obj[key])) {
				temp[lastPart] = parseHierarchyObj(obj[key]);
			} else {
				temp[lastPart] = obj[key];
			}
		}
	}

	return result;
}

function downloadFileFunc(downloadObj) {
	var errorFunc = function() {
		window._alert({ type: 'warn', message: failMsg });
	};
	
	if(!downloadObj) {
		errorFunc();
		return;
	}
    	
	var downloadUrl = downloadObj.url;
	var downloadParam = downloadObj.param;
	var fileName = downloadObj.fileName; 
	
	if(!downloadUrl || !downloadParam) {
		errorFunc();
		return;
	}
	
	validateAccessToken({
		successCallBackFunc: function() {

			window.$startSpinner();
            
			var req = new XMLHttpRequest();

            req.open('POST', prefixUrl + downloadUrl, true);

            req.setRequestHeader('Authorization', localStorage.getItem('accessToken'));
            req.setRequestHeader('X-iManager-Method', 'POST');
            
            req.withCredentials = true;
            req.responseType = 'blob';
            
            var param = JSON.parse(JSON.stringify(downloadParam));
            req.send(JSON.stringify(param));

            req.onload = function (event) {
                window.$stopSpinner();
                
                var disposition = req.getResponseHeader('Content-Disposition');
                
                var reqFileName = null;

				if (disposition && disposition.indexOf('attachment') !== -1) {
					let filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
					let matches = filenameRegex.exec(disposition);

					if (matches != null && matches[1]) reqFileName = matches[1].replace(/['"]/g, '');
				}
								
				var today = moment(new Date()).format('YYYYMMDD_HHmmss');
	
                var blob = req.response;
				var file_name = fileName ? fileName + "_" + today + ".xlsx" : reqFileName ? reqFileName : "Download_list_file_" + today + ".xlsx" ;
				
                if (blob.size <= 0) {
                	errorFunc();
            		return;
                }

                if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                    window.navigator.msSaveOrOpenBlob(blob, file_name);
                } else {
                    var link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    link.download = file_name;
                    link.click();
                    URL.revokeObjectURL(link.href);
                    link.remove();
                }
            };
		},
		errorCallBackFunc: function() {
			errorFunc();
			return;
		}
	});
}

function uploadFileFunc(uploadObj) {
	
	var errorFunc = function() {
		window._alert({ type: 'warn', message: failMsg });
	};
	
	if(!uploadObj) {
		errorFunc();
		return;
	}
    	
	var uploadUrl = uploadObj.url;
	var uploadData = uploadObj.param;
	var callback = uploadObj.callback;
	
	if(!uploadUrl || !uploadData) {
		errorFunc();
		return;
	}
	
	validateAccessToken({
		successCallBackFunc: function() {

			window.$startSpinner();
            
			var req = new XMLHttpRequest();

            req.open('POST', prefixUrl + uploadUrl, true);

            req.setRequestHeader('Authorization', localStorage.getItem('accessToken'));
            req.setRequestHeader('X-iManager-Method', 'POST');
            
            req.withCredentials = true;
            
            var formData = new FormData();
			formData.enctype = 'multipart/form-data';
			formData.append('uploadFile', uploadData);
			
			req.send(formData);

            req.onload = function (event) {
                window.$stopSpinner();
                
                if(callback) callback(req);
            };
		},
		errorCallBackFunc: function() {
			errorFunc();
			return;
		}
	});
}
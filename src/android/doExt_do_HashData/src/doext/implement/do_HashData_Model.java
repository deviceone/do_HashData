package doext.implement;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import core.helper.jsonparse.DoJsonNode;
import core.helper.jsonparse.DoJsonValue;
import core.interfaces.DoIHashData;
import core.interfaces.DoIScriptEngine;
import core.interfaces.datamodel.DoIDataSource;
import core.object.DoInvokeResult;
import doext.define.do_HashData_IMethod;
import doext.define.do_HashData_MAbstract;

/**
 * 自定义扩展MM组件Model实现，继承do_HashData_MAbstract抽象类，并实现do_HashData_IMethod接口方法；
 * #如何调用组件自定义事件？可以通过如下方法触发事件：
 * this.model.getEventCenter().fireEvent(_messageName, jsonResult);
 * 参数解释：@_messageName字符串事件名称，@jsonResult传递事件参数对象； 获取DoInvokeResult对象方式new
 * DoInvokeResult(this.getUniqueKey());
 */
public class do_HashData_Model extends do_HashData_MAbstract implements do_HashData_IMethod, DoIHashData, DoIDataSource {

	private DoJsonValue data;

	public do_HashData_Model() throws Exception {
		super();
		data = new DoJsonValue();
	}

	/**
	 * 同步方法，JS脚本调用该组件对象方法时会被调用，可以根据_methodName调用相应的接口实现方法；
	 * 
	 * @_methodName 方法名称
	 * @_dictParas 参数（K,V）
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public boolean invokeSyncMethod(String _methodName, DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		if ("getCount".equals(_methodName)) {
			getCount(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("addOne".equals(_methodName)) {
			addOne(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("addData".equals(_methodName)) {
			addData(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("getOne".equals(_methodName)) {
			getOne(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("getData".equals(_methodName)) {
			getData(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("removeOne".equals(_methodName)) {
			removeOne(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("removeData".equals(_methodName)) {
			removeData(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("removeAll".equals(_methodName)) {
			removeAll(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}
		if ("getAll".equals(_methodName)) {
			getAll(_dictParas, _scriptEngine, _invokeResult);
			return true;
		}

		return super.invokeSyncMethod(_methodName, _dictParas, _scriptEngine, _invokeResult);
	}

	/**
	 * 异步方法（通常都处理些耗时操作，避免UI线程阻塞），JS脚本调用该组件对象方法时会被调用， 可以根据_methodName调用相应的接口实现方法；
	 * 
	 * @_methodName 方法名称
	 * @_dictParas 参数（K,V）
	 * @_scriptEngine 当前page JS上下文环境
	 * @_callbackFuncName 回调函数名 #如何执行异步方法回调？可以通过如下方法：
	 *                    _scriptEngine.callback(_callbackFuncName,
	 *                    _invokeResult);
	 *                    参数解释：@_callbackFuncName回调函数名，@_invokeResult传递回调函数参数对象；
	 *                    获取DoInvokeResult对象方式new
	 *                    DoInvokeResult(this.getUniqueKey());
	 */
	@Override
	public boolean invokeAsyncMethod(String _methodName, DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, String _callbackFuncName) throws Exception {
		// ...do something
		return super.invokeAsyncMethod(_methodName, _dictParas, _scriptEngine, _callbackFuncName);
	}

	/**
	 * 增加数据；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void addData(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		DoJsonNode _newData = _dictParas.getOneNode("data");
		DoJsonNode _node = data.getNode();
		Map<String, DoJsonValue> _allKeyValues = _newData.getAllKeyValues();
		Set<String> _keySet = _allKeyValues.keySet();
		for (String _key : _keySet) {
			DoJsonValue _value = _allKeyValues.get(_key);
			_node.setOneValue(_key, _value);
		}
	}

	/**
	 * 增加一条数据；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void addOne(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		String _key = _dictParas.getOneText("key", "");
		DoJsonValue _value = _dictParas.getOneValue("value");
		data.getNode().setOneValue(_key, _value);
	}

	/**
	 * 获取元素个数；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void getCount(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		_invokeResult.setResultInteger(data.getArray().size());
	}

	/**
	 * 获取数据；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void getData(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		List<String> _keys = _dictParas.getOneTextArray("keys");
		List<DoJsonValue> _data = new ArrayList<DoJsonValue>();
		for (String _key : _keys) {
			DoJsonValue _value = data.getNode().getOneValue(_key);
			_data.add(_value);
		}
		_invokeResult.setResultArray(_data);
	}

	/**
	 * 获取某一行数据；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void getOne(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		String _key = _dictParas.getOneText("key", "");
		DoJsonValue _value = data.getNode().getOneValue(_key);
		_invokeResult.setResultValue(_value);
	}

	/**
	 * 清空数据；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void removeAll(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		data.getNode().getAllKeyValues().clear();
	}

	/**
	 * 根据keys删除多条数据；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void removeData(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		List<String> _keys = _dictParas.getOneTextArray("keys");
		for (String _key : _keys) {
			data.getNode().getAllKeyValues().remove(_key);
		}
	}

	/**
	 * 删除某一行数据；
	 * 
	 * @_dictParas 参数（K,V），可以通过此对象提供相关方法来获取参数值（Key：为参数名称）；
	 * @_scriptEngine 当前Page JS上下文环境对象
	 * @_invokeResult 用于返回方法结果对象
	 */
	@Override
	public void removeOne(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		String _key = _dictParas.getOneText("key", "");
		data.getNode().getAllKeyValues().remove(_key);
	}

	@Override
	public void getAll(DoJsonNode _dictParas, DoIScriptEngine _scriptEngine, DoInvokeResult _invokeResult) throws Exception {
		_invokeResult.setResultValue(data);
	}

	@Override
	public void getJsonData(DoGetJsonCallBack _callback) throws Exception {
		_callback.doGetJsonCallBack(data);
	}

	@Override
	public List<String> getAllKey() {
		return data.getNode().getAllKeys();
	}

	@Override
	public Object getData(String _key) {
		return data.getNode().getOneValue(_key);
	}
}
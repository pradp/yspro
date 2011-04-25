注意:此版本为 4.7 

使用：
在使用该日期控件的文件中加入WdatePicker.js库(仅这一个文件即可,其他文件会自动引入,请勿删除或改名), 
代码如下 <script language="javascript" type="text/javascript" src="...component/datepicker/WdatePicker.js"></script>
注意上面的“...”对应实际路径做修改。
然后在需要使用的页面上如下调用（精确到分钟）
<input type="text" onFocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"/>
精确到天
<input type="text" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>


官方网站：http://www.my97.net/dp/demo/
博客
http://my97.cnblogs.com
http://blog.csdn.net/my97/


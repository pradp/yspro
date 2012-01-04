<%@ page language="java" pageEncoding="UTF-8"%>

<div class="csTm" onmouseover='edit(this)' onmouseout='closeEdit(this)'>
	<div class="hiddenContext">
		<input type='hidden' name='wid'/>
		<input type='hidden' name='xmid'/>
		<input type='hidden' name='bjxx'/>
		<input type='hidden' name='xsxx'/>
		<input type='hidden' name='px'/>
		<input type='hidden' name='fz'/>
	</div>
	<div class='tmh'>
		<div class='tmbh'></div>
		<div class='tmbt'>请输入问题标题<label style="color: red"></label></div>
	</div> 
	<div class='tmxx tmh' align='left'>
		<ul>
			<li><input type='radio' name="xx_name">选项1<label style="color: blue" class="xxsm"></label><label style="color: blue" class="xxdf"></label></li> 
			<li><input type='radio' name="xx_name">选项2<label style="color: blue" class="xxsm"></label><label style="color: blue" class="xxdf"></label></li>
		</ul>
	</div>
	<div>
		<div class='edit' align='left'>
			<button type="button" onclick='editType(this)'><span class='icon_reply edit_bj'>完成</span></button> 
			<button type="button" onclick='addTm(this)'><span class='icon_reply'>复制</span></button> 
			<button type="button" onclick='deleteTm(this)'><span class='icon_delete'>删除</span></button> 
			<button type="button" onclick='moveTm(this,1)'><span class='icon_collapse'>上移</span></button> 
			<button type="button" onclick='moveTm(this,3)'><span class='icon_expand'>下移</span></button> 
			<button type="button" onclick='moveTm(this,2)'><span class='icon_btn_up'>置顶</span></button> 
			<button type="button" onclick='moveTm(this,4)'><span class='icon_btn_down'>置底</span></button>
		</div> 
	</div>
	<div class='whtm'> 
		<div align='left' class="divwh">
			维护标题：<input type='text' onblur='changeTitle(this)' style='width:300px' value='请输入问题标题'/>
			转换题型：<select onchange="changeTmType(this)" name="selectTmType">
						<option value="1">单选</option>
						<option value="2">多选</option>
						<option value="3">问答</option>
						<option value="4">排序</option>
						<option value="5">投票</option>
					 </select>
		</div> 
		<div align='left' class="divwh">填写提示：<input type='text' style='width:300px' onblur='changeTs(this)'/></div> 
		<div align='left' class="divwh">是否必答：<input type='checkbox' onclick='changeState(this)'/></div>
		<div align='left' class="divwh">批量增加选项：</div> 
		<div style='display:none' class="divwh" align='left'>
			<textarea class='textarea' style='width:300px;height:100px' onblur='addOption(this)'></textarea>
		</div> 
		<div class="divwh">
			<table class='xxlist' align="left">
				<tr>
					<th align="center" width="25%">选项</th>
					<th align="center" width="20%">操作</th>
					<th align="center" width="25%">说明</th>
					<th align="center" width="10%">得分</th>
					<th align="center" width="10%">跳题</th>
					<th align="center" width="10%">默认</th>
				</tr> 
				<tr>
					<td align="center"><input type='text' value='选项1' onblur='changeXx(this)'/></td> 
					<td nowrap="nowrap" align="center">
						<span class='img_add hand' title='插入' onclick="addXx(this)"></span>
						<span class='img_remove hand' title='删除' onclick="deleteXx(this)"></span>
						<span class='img_collapse hand' title='上移' onclick="moveXx(this,1)"></span>
						<span class='img_expand hand' title='下移' onclick="moveXx(this,3)"></span>
						<span class='img_btn_up hand' title='置顶' onclick="moveXx(this,2)"></span>
						<span class='img_btn_down hand' title='置底' onclick="moveXx(this,4)"></span>
					</td>
					<td align="center"><input type='text' onblur='changeXxTitle(this)'/></td>
					<td align="center"><input type='text' onblur='changeScore(this)' style="width:30px;" maxlength="3"
						 onkeypress="NumberText(event,false,false);" style="ime-mode:disabled"/></td>
					<td align="center"><input type='text' onblur='toOther(this)'  style="width:30px;" maxlength="3"
						 onkeypress="NumberText(event,false,false);" style="ime-mode:disabled"/></td>
					<td align="center"><input type='checkbox' class="cta_mr" onclick='chooseThisAnswer(this)'/></td>
				</tr> 
				<tr>
					<td align="center"><input type='text' value='选项2' onblur='changeXx(this)'/></td> 
					<td nowrap="nowrap" align="center">
						<span class='img_add hand' title='插入' onclick="addXx(this)"></span>
						<span class='img_remove hand' title='删除' onclick="deleteXx(this)"></span>
						<span class='img_collapse hand' title='上移' onclick="moveXx(this,1)"></span>
						<span class='img_expand hand' title='下移' onclick="moveXx(this,3)"></span>
						<span class='img_btn_up hand' title='置顶' onclick="moveXx(this,2)"></span>
						<span class='img_btn_down hand' title='置底' onclick="moveXx(this,4)"></span>
					</td>
					<td align="center"><input type='text' onblur='changeXxTitle(this)'/></td>
					<td align="center"><input type='text' onblur='changeScore(this)' style="width:30px;" maxlength="3"
						 onkeypress="NumberText(event,false,false);" style="ime-mode:disabled"/></td>
					<td align="center"><input type='text' onblur='toOther(this)'  style="width:30px;" maxlength="3"
						 onkeypress="NumberText(event,false,false);" style="ime-mode:disabled"/></td>
					<td align="center"><input type='checkbox' class="cta_mr" onclick='chooseThisAnswer(this)'/></td>
				</tr> 
			</table> 
		</div>
	</div>
</div>

<h2>Editing entry</h2>
<div id="entries">
  <div class="entry">
	$entry:{
    <form method="post" action="/save">
      <input name="id" type="hidden" value="$id$"/>
      <div class="header">
        <div class="title">
          <input name="title" type="text" value="$title$"/>
        </div>
      </div>
      <div class="content">
        <textarea name="content">$content$</textarea>
      </div>
      <input type="submit" value="Update Entry"/>
    </form>
	}$
  </div>
</div>

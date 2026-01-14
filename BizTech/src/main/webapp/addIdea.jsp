<form action="addIdea" method="post">

<input name="title" placeholder="Idea Title" required><br><br>

<select name="ideaType">
  <option>Student</option>
  <option>Small Business</option>
</select><br><br>

<input name="category" placeholder="Category"><br><br>
<textarea name="problem" placeholder="Problem"></textarea><br><br>
<textarea name="solution" placeholder="Solution"></textarea><br><br>
<input name="targetMarket" placeholder="Target Market"><br><br>

<select name="stage">
  <option>Idea</option>
  <option>Prototype</option>
  <option>Running</option>
</select><br><br>

<textarea name="description" placeholder="Description"></textarea><br><br>

<button type="submit">Save Idea</button>

</form>

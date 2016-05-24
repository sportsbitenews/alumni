var CityForm = React.createClass({
  render: function() {
    return (
      <div className="container padded">
        <form action="" className="simple_form edit_city" id="edit_city" method="post">
          <div className="form-group city_specifics text optional">
            <textarea name="city[specifics]" id="city_specifics" rows="20" className="text optional form-control"></textarea>
          </div>
          <div className="text-right padded-1em form-group">
            <button className="btn btn-default button-discret form-control">Preview</button>
            <input type="submit" className="btn btn-default button-discret form-control" value="Update" />
          </div>
        </form>
      </div>
    );
  }
});

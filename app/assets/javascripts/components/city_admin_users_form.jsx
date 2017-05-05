var CityAdminUsersForm = React.createClass({
  getInitialState() {
    return {
      editing: false
    };
  },
  render: function() {
    var innerComponnentClasses = classNames({
      'hidden': !this.state.editing
    });
    var editBtnClasses = classNames({
      'hidden': this.state.editing,
      'manager-button': true,
      'manager-button-edit': true
    });
    return (
      <div className=''>
        <div className={editBtnClasses} onClick={this.handleEditClick}>Edit</div>
        <div className={innerComponnentClasses}>
          <div className='city_edit_teacher_info text-left'>
            <form action="" className="simple_form padded-1em side-padded-1em" onSubmit={(e) => { this.handleSubmit(e, this.props.member) }}>
              <div className='form-group bottom-padded-1em'>
                <div className=''>Photo</div>
                <div className=''>
                  <input className='' type="file" name='photo' ref='photo' />
                </div>
              </div>
              <div className='bottom-padded-1em form-group'>
                <div className=''>First name</div>
                <div className=''>
                  <input className='form-control' type="text" name='role' defaultValue={this.props.member.first_name} ref='first_name' />
                </div>
              </div>
              <div className='bottom-padded-1em form-group'>
                <div className=''>Last name</div>
                <div className=''>
                  <input className='form-control' type="text" name='role' defaultValue={this.props.member.last_name} ref='last_name' />
                </div>
              </div>
              <div className='bottom-padded-1em form-group'>
                <div className=''>Role</div>
                <div className=''>
                  <input className='form-control' type="text" name='role' defaultValue={this.props.member.role} ref='role' />
                </div>
              </div>
              <div className='bottom-padded-1em form-group'>
                <div className='teacher_info_label twitter'><i className="mdi mdi-twitter" /> twitter nickname</div>
                <div className=''>
                  <input className='form-control' type="text" name='twitter_nickname' defaultValue={this.props.member.twitter_nickname} ref='twitter_nickname' />
                </div>
              </div>
              <div className='bottom-padded-1em form-group'>
                <div className='teacher_info_area'>
                  <div className='teacher_info_label'>Bio 🇫🇷</div>
                  <textarea className='form-control' type="text" name='bio_fr' defaultValue={this.props.member.bio_fr} ref='bio_fr' />
                </div>
              </div>
              <div className='bottom-padded-1em form-group'>
                <div className='teacher_info_area'>
                  <div className='teacher_info_label'>Bio 🇬🇧</div>
                  <textarea className='form-control' type="text" name='bio_en' defaultValue={this.props.member.bio_en} ref='bio_en' />
                </div>
              </div>
              <button className='btn btn-primary' type='submit'>Update</button>
              <div className='btn btn-primary' onClick={this.handleCancelClick}>Cancel</div>
            </form>
          </div>
        </div>
      </div>
    )
  },
  handleEditClick(e) {
    e.preventDefault();
    this.setState({ editing: true });
  },
  handleCancelClick(e) {
    e.preventDefault();
    this.setState({ editing: false });
  },
  handleSubmit(e, member) {
    e.preventDefault();
    var fd = new FormData();
    var inputPhoto = this.refs.photo.getDOMNode().files[0];
    if (typeof(inputPhoto) != "undefined") {
      fd.append('user[photo]', inputPhoto);
    }
    fd.append('user[twitter_nickname]', React.findDOMNode(this.refs.twitter_nickname).value);
    fd.append('user[first_name]', React.findDOMNode(this.refs.first_name).value);
    fd.append('user[last_name]', React.findDOMNode(this.refs.last_name).value);
    fd.append('user[role]', React.findDOMNode(this.refs.role).value);
    fd.append('user[bio_en]', React.findDOMNode(this.refs.bio_en).value);
    fd.append('user[bio_fr]', React.findDOMNode(this.refs.bio_fr).value);
    fd.append('ordered_list_id', member.ordered_list_id)
    var that = this;
    $.ajax({
      url: Routes.city_admin_user_path(member.github_nickname),
      data: fd,
      processData: false,
      contentType: false,
      type: 'PATCH',
      success: function(data){
        that.setState({ editing: false });
        that.props.updateMember(data.member);
      }
    });
  }
});

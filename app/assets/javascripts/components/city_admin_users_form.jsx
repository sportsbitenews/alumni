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
              <div className='form-group attachinary bottom-padded-1em'>
                <div className=''>Photo</div>
                <div className=''>
                  <input className='' type="file" name='photo' defaultValue={this.props.member.photo_path} ref='photo' />
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
    axios.railsPatch(
      Routes.city_admin_user_path(member.github_nickname, { format: 'json' }),
      {
        'twitter_nickname': React.findDOMNode(this.refs.twitter_nickname).value,
        'role': React.findDOMNode(this.refs.role).value,
        'bio_en': React.findDOMNode(this.refs.bio_en).value,
        'bio_fr': React.findDOMNode(this.refs.bio_fr).value,
        'photo': React.findDOMNode(this.refs.photo).value
      }
    ).then((response) => {
      this.setState({ editing: false });
    });
  }
});

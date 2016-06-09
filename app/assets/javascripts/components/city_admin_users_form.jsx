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
          <div className='city_edit_teacher_info'>
            <form action="" className="simple_form padded-1em side-padded-1em" onSubmit={(e) => { this.handleSubmit(e, this.props.member) }}>
              <div className='bottom-padded-05em flex'>
                <div className='teacher_info_input'>
                  <div className='teacher_info_label'>Role</div>
                  <div className=''>
                    <input className='form-control' type="text" name='role' defaultValue={this.props.member.role} ref={this.props.member.github_nickname+'_role'} />
                  </div>
                </div>
                <div className='teacher_info_input'>
                  <div className='teacher_info_label twitter'><i className="mdi mdi-twitter" /></div>
                  <div className=''>
                    <input className='form-control' type="text" name='twitter_nickname' defaultValue={this.props.member.twitter_nickname} ref={this.props.member.github_nickname+'_twitter_nickname'} />
                  </div>
                </div>
              </div>
              <div className='bottom-padded-05em flex'>
                <div className='teacher_info_area'>
                  <div className='teacher_info_label'>Bio 🇫🇷</div>
                  <textarea className='form-control' type="text" name='bio_fr' defaultValue={this.props.member.bio_fr} ref={this.props.member.github_nickname+'_bio_fr'} />
                </div>
              </div>
              <div className='bottom-padded-05em flex'>
                <div className='teacher_info_area'>
                  <div className='teacher_info_label'>Bio 🇬🇧</div>
                  <textarea className='form-control' type="text" name='bio_en' defaultValue={this.props.member.bio_en} ref={this.props.member.github_nickname+'_bio_en'} />
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
        'twitter_nickname': React.findDOMNode(this.refs[member.github_nickname+'_twitter_nickname']).value,
        'role': React.findDOMNode(this.refs[member.github_nickname+'_role']).value,
        'bio_en': React.findDOMNode(this.refs[member.github_nickname+'_bio_en']).value,
        'bio_fr': React.findDOMNode(this.refs[member.github_nickname+'_bio_fr']).value
      }
    ).then((response) => {
      this.setState({ editing: false });
    });
  }
});

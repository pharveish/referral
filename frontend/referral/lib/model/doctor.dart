class Doctor{
	int _id;
	String _username;
	String _password;
	String _email;
	String _name;
	String _credentials;
	String _specialty;
	String _hospital;
	String _officePhone;
	String _mobilePhone;
	String _fax;

	get id =>_id;
	set id(value) => _id=value;

	get username =>_username;
	set username(value) => _username=value;

	get password =>_password;
	set password(value) => _password=value;

	get email =>_email;
	set email(value) => _email=value;

	get name =>_name;
	set name(value) => _name=value;

	get credentials =>_credentials;
	set credentials(value) => _credentials=value;

	get specialty =>_specialty;
	set specialty(value) => _specialty=value;

	get hospital =>_hospital;
	set hospital(value) => _hospital=value;

	get officePhone =>_officePhone;
	set officePhone(value) => _officePhone=value;

	get mobilePhone =>_mobilePhone;
	set mobilePhone(value) => _mobilePhone=value;

	get fax =>_fax;
	set fax(value) => _fax=value;

	Doctor({
		int id,
		String username = '',
		String password = '',
		String email = '',
		String name = '',
		String credentials = '',
		String specialty = '',
		String hospital = '',
		String officePhone = '',
		String mobilePhone = '',
		String fax = '',
	}) : 	_id = id,
				_username = username,
				_password = password,
				_email = email,
				_name = name,
				_credentials = credentials,
				_hospital = hospital,
				_specialty = specialty,
				_mobilePhone = mobilePhone,
				_officePhone = officePhone,
				_fax = fax;

	Doctor.copy(Doctor from)
			: this(
					id: from.id,
					username: from.username,
					password: from.password,
					email: from.email,
					name: from.name,
					credentials: from.credentials,
					specialty: from.specialty,
					hospital: from.hospital,
					mobilePhone: from.mobilePhone,
					officePhone: from.officePhone,
					fax: from.fax,
			);

	Doctor.fromJson(Map<String, dynamic> json)
			:this(
					id: json['id'],
					username: json['username'],
					password: json['password'],
					email: json['email'],
					name: json['name'],
					credentials: json['credentials'],
					specialty: json['specialty'],
					hospital: json['hospital'],
					mobilePhone: json['mobilePhone'],
					officePhone: json['officePhone'],
					fax: json['fax'],
			);

	Map<String, dynamic> toJson() => {
		'id': id,
		'username': username,
		'password': password,
		'email': email,
		'name': name,
		'credentials': credentials,
		'specialty': specialty,
		'hospital': hospital,
		'mobilePhone': mobilePhone,
		'officePhone': officePhone,
		'fax': fax,
	};
}

class AdModel {
  final int id;
  final String nombre;
  final String link;
  final String estado;
  final String municipio;
  final String localidad;
  final String direccion;
  final String referencia;
  final String colonia;
  final int cp;
  final String telefono;
  final String telefono2;
  final String email;
  final String sitioweb;
  final String facebook;
  final String twitter;
  final String youtube;
  final String instagram;
  final String skype;
  final String keywordprimary;
  final String keywordsecondary;
  final String descripcion;
  final String descripcionAdicional;
  final String logo;
  final String portada;
  final String horarios;
  final String comodidades;
  final int active;
  final int userId;
  final String usuvoto;
  final String voto;
  final String bannerLateral;

  AdModel({
    required this.id,
    required this.nombre,
    required this.link,
    required this.estado,
    required this.municipio,
    required this.localidad,
    required this.direccion,
    required this.referencia,
    required this.colonia,
    required this.cp,
    required this.telefono,
    required this.telefono2,
    required this.email,
    required this.sitioweb,
    required this.facebook,
    required this.twitter,
    required this.youtube,
    required this.skype,
    required this.active,
    required this.bannerLateral, 
    required this.comodidades,
    required this.descripcion,
    required this.descripcionAdicional,
    required this.horarios,
    required this.instagram,
    required this.keywordprimary,
    required this.keywordsecondary,
    required this.logo,
    required this.portada,
    required this.userId,
    required this.usuvoto,
    required this.voto
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      nombre: json['nombre'],
      link: json['link'],
      estado: json['estado'],
      municipio: json['municipio'],
      localidad: json['localidad'],
      direccion: json['direccion'],
      referencia: json['referencia'],
      colonia: json['colonia'],
      cp: json['cp'],
      telefono: json['telefono'],
      telefono2: json['telefono2'],
      email: json['email'],
      sitioweb: json['sitioweb'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      skype: json['skype'],
      youtube: json['youtube'],
      instagram: json['instagram'],
      keywordprimary: json['keywordprimary'],
      keywordsecondary: json['keywordsecondary'],
      descripcion: json['descripcion'],
      descripcionAdicional: json['descripcion_adicional'],
      logo: json['logo'],
      portada: json['portada'],
      horarios: json['horarios'],
      comodidades: json['comodidades'],
      active: json['active'],
      userId: json['user_id'],
      usuvoto: json['usu_voto'],
      voto: json['voto'],
      bannerLateral: json['banner_lateral'],
    );
  }
}

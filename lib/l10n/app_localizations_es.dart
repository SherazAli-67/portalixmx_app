// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Portalixmx';

  @override
  String get residentLogin => 'Acceso de Residentes';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get forgetPassword => 'Olvida tu contraseña';

  @override
  String get selectSociety => 'Seleccionar comunidad';

  @override
  String get failedToLoadSocieties =>
      'No se pudieron cargar las comunidades. Inténtalo de nuevo.';

  @override
  String get retry => 'Reintentar';

  @override
  String accountRequestPending(String societyName) {
    return 'Tu solicitud de residente para $societyName está pendiente. Se te notificará cuando el administrador actualice tu solicitud';
  }

  @override
  String welcomeMessage(Object name) {
    return 'Bienvenido $name';
  }

  @override
  String get regularVisitors => 'Visitantes Frecuentes';

  @override
  String get guest => 'Invitado';

  @override
  String get year => 'Año';

  @override
  String get pending => 'Pendiente';

  @override
  String get approved => 'Aprobado';

  @override
  String get paymentDetails => 'Detalles del pago';

  @override
  String get paymentFor => 'Pago por';

  @override
  String get status => 'Estado';

  @override
  String get description => 'Descripción';

  @override
  String get amount => 'Monto';

  @override
  String get receipt => 'Recibo de pago';

  @override
  String get received => 'Recibido';

  @override
  String get submitted => 'Enviado';

  @override
  String get paymentDetail => 'Detalles del pago';

  @override
  String get accessRequests => 'Solicitudes de Acceso';

  @override
  String get poolAccess => 'Acceso a la Piscina';

  @override
  String get add => 'Agregar';

  @override
  String get twoStepVerification => 'Verificación en 2 Pasos';

  @override
  String get twoStepVerificationDescription =>
      'Ingrese el código de verificación de 2 pasos enviado a su correo electrónico';

  @override
  String get otp => 'Código OTP';

  @override
  String get submit => 'Enviar';

  @override
  String get needHelp => '¿Necesitas ayuda?';

  @override
  String get home => 'Inicio';

  @override
  String get payments => 'Pagos';

  @override
  String get maintenance => 'Mantenimiento';

  @override
  String get access => 'Acceso';

  @override
  String get menu => 'Menú';

  @override
  String get regularVisitor => 'Visitante Frecuente';

  @override
  String get requestedTime => 'HORA SOLICITADA';

  @override
  String get accessFor => 'Acceso Para';

  @override
  String get teacher => 'Profesor';

  @override
  String get accessApprovedDate => 'Fecha de Aprobación de Acceso';

  @override
  String get contactNum => 'Número de Contacto';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get from => 'De';

  @override
  String get to => 'A';

  @override
  String get shareKey => 'Compartir Clave';

  @override
  String get qrCode => 'CÓDIGO QR';

  @override
  String get paymentsAndBilling => 'Pagos y Facturación';

  @override
  String get currentService => 'Servicio Actual';

  @override
  String get otherServices => 'Otros Servicios';

  @override
  String get serviceName => 'Nombre del Servicio';

  @override
  String get cleaningOfCommonAreas => 'Limpieza de áreas comunes';

  @override
  String get garbageCollection => 'Recolección de basura';

  @override
  String get complaint => 'Queja';

  @override
  String get uploadPhotos => 'Subir Fotos';

  @override
  String get openCamera => 'Abrir Cámara';

  @override
  String get requestAccess => 'Solicitar Acceso';

  @override
  String get viewProfile => 'Ver Perfil';

  @override
  String get directory => 'Directorio';

  @override
  String get communityCalendar => 'Calendario Comunitario';

  @override
  String get communityPolls => 'Encuestas Comunitarias';

  @override
  String pollEndsAt(String when) {
    return 'Termina $when';
  }

  @override
  String get pollVote => 'Votar';

  @override
  String get pollAlreadyVoted => 'Ya votaste';

  @override
  String get pollEnded => 'Esta encuesta ha terminado';

  @override
  String get pollVoteFailed => 'No se pudo enviar el voto';

  @override
  String get pollSelectOption => 'Selecciona una opción';

  @override
  String get guards => 'Guardias';

  @override
  String get carPooling => 'Compartir Auto';

  @override
  String get emergencyCalls => 'Llamadas de Emergencia';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get search => 'Buscar';

  @override
  String get guardTracking => 'Seguimiento de Guardias';

  @override
  String get name => 'Nombre';

  @override
  String get phone => 'Teléfono';

  @override
  String get emergencyContacts => 'Contactos de Emergencia';

  @override
  String get vehicleInformation => 'Información del Vehículo';

  @override
  String get vehicleName => 'Nombre del Vehículo';

  @override
  String get licensePlateNumber => 'Número de Placa';

  @override
  String get registrationNumber => 'Número de Registro';

  @override
  String get update => 'Actualizar';

  @override
  String get color => 'Color';

  @override
  String get profile => 'Perfil';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String updateYour(Object userInfo) {
    return 'Actualiza tu $userInfo';
  }

  @override
  String get addGuest => 'Agregar Invitado';

  @override
  String get deleteComplaint => 'Eliminar Queja';

  @override
  String get profileInfoUpdated => 'Información de perfil actualizada';

  @override
  String get profileInfoUpdateFailed =>
      'Error al actualizar el perfil, por favor intenta de nuevo';

  @override
  String get show => 'Mostrar';

  @override
  String get hide => 'Ocultar';

  @override
  String get deleteVisitor => 'Eliminar Visitante';

  @override
  String get deleteGuest => 'Eliminar invitado';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get editGuest => 'Editar Invitado';

  @override
  String get carPlateNumber => 'Número de Placa del Auto';

  @override
  String get vehicleModel => 'Modelo del Vehículo';

  @override
  String get time => 'Hora';

  @override
  String get date => 'Fecha';

  @override
  String get dateFrom => 'Fecha desde';

  @override
  String get dateTo => 'Fecha hasta';

  @override
  String hasBeenEditedMessage(Object name) {
    return '$name ha sido actualizado';
  }

  @override
  String hasBeenAddedMessage(Object guestType, Object name) {
    return '$name ha sido agregado como $guestType';
  }

  @override
  String accessRequestPending(Object accessTitle) {
    return 'La solicitud de $accessTitle ya está en estado pendiente';
  }

  @override
  String accessRequestSubmitted(Object accessTitle) {
    return 'La solicitud de $accessTitle ha sido enviada al administrador de Portalix';
  }

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get createAccountDescription =>
      'Crea una cuenta con Portalixmx y comienza con la gestión de la comunidad';

  @override
  String get alreadyHaveAnAccount => '¿Ya tienes una cuenta? ';

  @override
  String get dontHaveAnAccount => '¿No tienes una cuenta? ';

  @override
  String get completeProfile => 'Completar perfil';

  @override
  String get completeProfileDescription =>
      'Proporciona el resto de la información para completar tu perfil';

  @override
  String get additionalDetails => 'Detalles adicionales';

  @override
  String get pleaseEnterName => 'Por favor ingrese el nombre';

  @override
  String get pleaseEnterContactNumber =>
      'Por favor ingrese el número de contacto';

  @override
  String get pleaseEnterCarPlateNumber =>
      'Por favor ingrese el número de placa del auto';

  @override
  String get pleaseEnterVehicleModel =>
      'Por favor ingrese el modelo del vehículo';

  @override
  String get pleaseEnterColor => 'Por favor ingrese el color';

  @override
  String get pleaseSelectFromDateTime =>
      'Por favor seleccione la fecha y hora de inicio';

  @override
  String get pleaseSelectToDateTime =>
      'Por favor seleccione la fecha y hora de fin';

  @override
  String get toDateTimeMustBeAfterFromDateTime =>
      'La fecha/hora de fin debe ser posterior a la fecha/hora de inicio';

  @override
  String get pleaseSelectAtLeastOneDay =>
      'Por favor seleccione al menos un día con horario';

  @override
  String get visitorAddedSuccessfully => 'Visitante agregado exitosamente';

  @override
  String get visitorUpdatedSuccessfully => 'Visitante actualizado exitosamente';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get error => 'Error';

  @override
  String get all => 'Todos';

  @override
  String get week => 'Semana';

  @override
  String get month => 'Mes';

  @override
  String get automaticVisitorCode => 'Código de visitante';

  @override
  String get generateAccessCode => 'Generar código de acceso';

  @override
  String get myAccessQr => 'Mi código QR de acceso';

  @override
  String get myAccessQrDescription =>
      'Muestre este código QR en el lector de la puerta para entrar a la comunidad.';

  @override
  String get refreshQr => 'Actualizar QR';

  @override
  String get shareQrCode => 'Compartir QR';

  @override
  String get zkbioNotConfigured =>
      'El acceso con puerta aún no está configurado para su comunidad.';

  @override
  String get accountNotApprovedForQr =>
      'Su cuenta debe ser aprobada por el administrador antes de usar el QR de acceso.';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get guestAccessQr => 'QR de acceso para invitado';

  @override
  String get guestQrShowAtDoor =>
      'Muestre este QR en el lector de la puerta durante la ventana de visita.';

  @override
  String get guestQrUnavailable =>
      'No se pudo cargar el QR de acceso del invitado.';

  @override
  String get guestVisitEnded => 'Esta visita de invitado ha finalizado.';

  @override
  String get guestQrOutsideWindow =>
      'El QR del invitado solo está disponible durante la ventana programada.';

  @override
  String get close => 'Cerrar';

  @override
  String get fundManagement => 'Gestión de Fondos';

  @override
  String get createFundReport => 'Crear Informe de Fondos';

  @override
  String get reportTitle => 'Título del Informe';

  @override
  String get income => 'Ingresos';

  @override
  String get expenses => 'Gastos';

  @override
  String get expenseLabel => 'Concepto del Gasto';

  @override
  String get addExpense => 'Agregar Gasto';

  @override
  String get balance => 'Saldo';

  @override
  String get note => 'Nota';

  @override
  String get publishReport => 'Publicar Informe';

  @override
  String get saveAsDraft => 'Guardar como Borrador';

  @override
  String get published => 'Publicado';

  @override
  String get draft => 'Borrador';

  @override
  String get emptyFundReportsMsg => 'Aún no hay informes de fondos';

  @override
  String get totalExpenses => 'Gastos Totales';

  @override
  String get noExpenses => 'No hay gastos registrados';

  @override
  String get emergencyCall => 'LLAMADA DE EMERGENCIA';

  @override
  String get removeContact => 'Eliminar contacto';

  @override
  String get selectEmergencyContacts => 'Seleccionar contactos de emergencia';

  @override
  String get saveContacts => 'Guardar';

  @override
  String get emergencyAlertSent => 'Notificación de emergencia enviada';

  @override
  String get emergencyAlertFailed =>
      'No se pudo enviar la alerta de emergencia';

  @override
  String get addEmergencyContactsFirst =>
      'Agrega contactos de emergencia primero';

  @override
  String get noResidentsFound => 'No se encontraron residentes';

  @override
  String get noEmergencyContacts => 'No hay contactos de emergencia';

  @override
  String get holdToSendEmergency => 'Mantén presionado 3 segundos para enviar';

  @override
  String get refresh => 'Actualizar';

  @override
  String get society => 'Comunidad';

  @override
  String get accountStillPending =>
      'Tu cuenta aún está pendiente de aprobación';

  @override
  String get unableToRefreshStatus =>
      'No se pudo actualizar el estado. Inténtalo de nuevo.';

  @override
  String get guestsDirectory => 'Directorio de invitados';

  @override
  String get noVisitorFound => 'No se encontró visitante';

  @override
  String get addNewGuest => 'Agregar nuevo invitado';

  @override
  String get signupFailed => 'Registro fallido';

  @override
  String get resetPasswordLinkSent =>
      'Se ha enviado un enlace para restablecer la contraseña a tu correo electrónico. Puedes actualizar tu contraseña desde allí.';

  @override
  String get noPollsYet => 'Aún no hay encuestas';

  @override
  String get noEventsYet => 'Aún no hay eventos';

  @override
  String get noPaymentRequestsFound => 'No se encontraron solicitudes de pago';

  @override
  String get receiptSubmittedToAdmin =>
      'Tu recibo ha sido enviado al administrador';

  @override
  String accessTitleLabel(String title) {
    return 'Acceso a $title';
  }

  @override
  String get photos => 'Fotos';

  @override
  String get visitorType => 'Tipo de visitante';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get vehicleNameHint => 'ej. ALTO';

  @override
  String get colorHint => 'ej. Negro';

  @override
  String get licenseNumberHint => 'Número de licencia';

  @override
  String get receiptUnavailable => 'Recibo no disponible';

  @override
  String get select => 'Seleccionar';

  @override
  String get informationUnavailable => 'Información no disponible';

  @override
  String get contact => 'Contacto';

  @override
  String get guardInfoUnavailable =>
      'La información del guardia no está disponible';

  @override
  String get selectDateForAccessRequest =>
      'Selecciona una fecha para la solicitud de acceso';

  @override
  String get selectTimeForAccessRequest =>
      'Selecciona una hora para la solicitud de acceso';

  @override
  String get selectAccessForRequest => 'Selecciona el acceso para la solicitud';

  @override
  String get pleaseUploadReceipt => 'Sube un recibo antes de enviar';

  @override
  String get visitorDeletedSuccessfully => 'Visitante eliminado exitosamente';

  @override
  String get failedToDeleteVisitor =>
      'No se pudo eliminar el visitante. Inténtalo de nuevo.';

  @override
  String get loginFailed => 'Inicio de sesión fallido. Inténtalo de nuevo.';

  @override
  String get pleaseEnterVehicleName =>
      'Por favor ingresa el nombre del vehículo';

  @override
  String get pleaseEnterVehicleColor =>
      'Por favor ingresa el color del vehículo';

  @override
  String get pleaseEnterLicensePlate =>
      'Por favor ingresa el número de placa del vehículo';

  @override
  String get pleaseEnterRegistrationNumber =>
      'Por favor ingresa el número de registro del vehículo';

  @override
  String get nameCannotBeEmpty =>
      'El nombre no puede estar vacío. Por favor ingresa tu nombre';

  @override
  String get portalixAccessQr => 'QR de acceso Portalix';

  @override
  String get emailRequired => 'El correo electrónico es obligatorio';

  @override
  String get pleaseEnterValidEmail =>
      'Por favor ingresa un correo electrónico válido';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get fullNameRequired => 'El nombre completo es obligatorio';

  @override
  String get fullNameMinLength =>
      'El nombre completo debe tener al menos 2 caracteres';

  @override
  String get appointmentDateRequired => 'La fecha de la cita es obligatoria';

  @override
  String get dayMustBeBetween => 'El día debe estar entre 1 y 31';

  @override
  String get pleaseUploadProfilePicture => 'Por favor sube tu foto de perfil';

  @override
  String get userNotFound => 'Usuario no encontrado';

  @override
  String get userNotFoundLoginAgain =>
      'Usuario no encontrado. Inicia sesión de nuevo';

  @override
  String get accountMustBeApprovedForQr =>
      'La cuenta debe estar aprobada antes de generar el QR de acceso';

  @override
  String get inProgress => 'En progreso';

  @override
  String get resolved => 'Resuelto';

  @override
  String get rejected => 'Rechazado';

  @override
  String get authInvalidEmail =>
      'La dirección de correo electrónico no es válida.';

  @override
  String get authUserDisabled =>
      'Esta cuenta de usuario ha sido deshabilitada.';

  @override
  String get authUserNotFound =>
      'No se encontró ningún usuario con ese correo.';

  @override
  String get authWrongPassword => 'Contraseña incorrecta para ese usuario.';

  @override
  String get authEmailAlreadyInUse =>
      'La dirección de correo ya está en uso por otra cuenta.';

  @override
  String get authOperationNotAllowed =>
      'Las cuentas de correo/contraseña no están habilitadas.';

  @override
  String get authWeakPassword =>
      'La contraseña proporcionada es demasiado débil.';

  @override
  String get authInvalidCredential =>
      'El correo o la contraseña proporcionados no son válidos.';

  @override
  String get authUnknownError => 'Ocurrió un error desconocido.';

  @override
  String get zkbioAccessFailed => 'Falló el acceso a la puerta';
}
